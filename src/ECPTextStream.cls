VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ECPTextStream"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' Copyright © 2020 W. García
' GPL-3.0 license | https://www.gnu.org/licenses/gpl-3.0.html/
' https://ingwilfredogarcia.wordpress.com
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' GENERAL INFO:
' ECPTextStream is an easy-to-use class module developed to enable I/O operations over "big"
' text files, at high speed, from VBA. The module hasn’t reference to any external API library.
'////////////////////////////////////////////////////////////////////////////////////////////
'#
Option Explicit
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' CONSTANTS:
Private Const SizeFactor As Long = 524288
'////////////////////////////////////////////////////////////////////////////////////////////
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' PROPERTIES VARIABLES:
Private P_ATENDOFSTREAM As Boolean '---------------Indicates if the file's end is reached.
Private P_BUFFERLENGTH As Long '-------------------Number of chars in buffer.
Private P_BUFFERSIZE As Single '-------------------Buffer's size in MB (0.5 by default).
Private P_ENDSTREAMONLINEBREAK As Boolean '--------If true, each stream ends on a line break.
Private P_LINEBREAK As String '--------------------Holds the char used to end a Stream.
Private P_STREAMLENGTH As Long '-------------------File len.
Private P_TEXT As String '-------------------------Holds the current stream's text.
'////////////////////////////////////////////////////////////////////////////////////////////
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' VARIABLES:
' @Common
'////////////////////////////////////////////////////////////////////////////////////////////
'#
Private Buffer As String
Private BufferDelta As Long
Private BufferEnds As Boolean
Private BufferMark As Long
Private CorrectedPos As Long
Private EndLineMark As EndLineChar
Private FileHandled As Integer
Private InitialPos As Long
Private LCS As Long
Private IsOpenStream As Boolean
Private tmpStr As String
'////////////////////////////////////////////////////////////////////////////////////////////
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' ENUMERATIONS:
Public Enum EndLineChar
    CRLF = 0
    CR = 1
    LF = 2
End Enum
'////////////////////////////////////////////////////////////////////////////////////////////
'#
' PROPERTIES:
Public Property Get AtEndOfStream() As Boolean
Attribute AtEndOfStream.VB_Description = "Gets the pointer’s overall status over the text stream."
    AtEndOfStream = P_ATENDOFSTREAM
End Property
Public Property Get BufferLength() As Long
Attribute BufferLength.VB_Description = "Gets the number of string characters in the buffer."
    BufferLength = P_BUFFERLENGTH
End Property
Public Property Get BufferSize() As Single
Attribute BufferSize.VB_Description = "Gets or sets the buffer’s size, in MB, for text stream operations."
    BufferSize = P_BUFFERSIZE
End Property
Public Property Let BufferSize(Value As Single)
    P_BUFFERSIZE = Value
    P_BUFFERLENGTH = CLng(P_BUFFERSIZE * SizeFactor)
    Buffer = Space$(P_BUFFERLENGTH)
End Property
Public Property Get BufferString() As String
Attribute BufferString.VB_Description = "Gets the text data stored in the buffer."
    BufferString = P_TEXT
End Property
Public Property Get EndStreamOnLineBreak() As Boolean
Attribute EndStreamOnLineBreak.VB_Description = "Allows to end buffer just after the first, from right to left, line break character."
    EndStreamOnLineBreak = P_ENDSTREAMONLINEBREAK
End Property
Public Property Let EndStreamOnLineBreak(Value As Boolean)
    P_ENDSTREAMONLINEBREAK = Value
End Property
Public Property Get LineBreak() As String
Attribute LineBreak.VB_Description = "Returns the character used to end the last received stream. The value is vbNullString when the last stream is not forced to end on line break."
    LineBreak = P_LINEBREAK
End Property
Public Property Get PointerPosition() As Long
Attribute PointerPosition.VB_Description = "Gets the overall pointer position over the current text file."
    If IsOpenStream Then
        PointerPosition = Seek(FileHandled)
    Else
        PointerPosition = 0
    End If
End Property
Public Property Get StreamLength() As Long
Attribute StreamLength.VB_Description = "Gets the current opened file’s size, in Bytes."
    StreamLength = P_STREAMLENGTH
End Property
'////////////////////////////////////////////////////////////////////////////////////////////
'#
'////////////////////////////////////////////////////////////////////////////////////////////
' METHODS:
Public Sub CloseStream()
Attribute CloseStream.VB_Description = "Closes the current text file stream."
    If IsOpenStream Then
        Close #FileHandled
        IsOpenStream = False
    End If
End Sub
Public Sub OpenStream(FilePath As String)
Attribute OpenStream.VB_Description = "Opens a stream over a text file."
    FileHandled = FreeFile
    Open FilePath For Binary As #FileHandled
    IsOpenStream = True
    P_STREAMLENGTH = LOF(FileHandled)
    StartVariables
End Sub
Public Sub ReadText()
Attribute ReadText.VB_Description = "Reads a number of characters from the stream file and saves the result to the current instance."
    If Not P_ATENDOFSTREAM And IsOpenStream Then
        Select Case P_BUFFERLENGTH
            Case Is < LCS
                BufferDelta = 0
                BufferEnds = False
                Get #FileHandled, , Buffer
                InitialPos = Seek(FileHandled)
                BufferMark = LenB(Buffer)
                If P_ENDSTREAMONLINEBREAK Then
                    BufferEnds = (MidB$(Buffer, BufferMark - 3, 4) = vbCrLf)
                    Select Case BufferEnds
                        Case False
                            BufferEnds = (MidB$(Buffer, BufferMark - 1, 2) = vbCr)
                            Select Case BufferEnds
                                Case False
                                    BufferEnds = (MidB$(Buffer, BufferMark - 1, 2) = vbLf)
                                    If BufferEnds Then
                                        P_LINEBREAK = vbLf
                                    End If
                                Case Else
                                    P_LINEBREAK = vbCr
                            End Select
                        Case Else
                            P_LINEBREAK = vbCrLf
                    End Select
                    Do While Not BufferEnds
                        BufferMark = BufferMark - 2
                        BufferDelta = BufferDelta + 1
                        BufferEnds = (MidB$(Buffer, BufferMark - 3, 4) = vbCrLf)
                        Select Case BufferEnds
                            Case False
                                BufferEnds = (MidB$(Buffer, BufferMark - 1, 2) = vbCr)
                                Select Case BufferEnds
                                    Case False
                                        BufferEnds = (MidB$(Buffer, BufferMark - 1, 2) = vbLf)
                                        If BufferEnds Then
                                            P_LINEBREAK = vbLf
                                        End If
                                    Case Else
                                        P_LINEBREAK = vbCr
                                End Select
                            Case Else
                                P_LINEBREAK = vbCrLf
                        End Select
                    Loop
                    CorrectedPos = InitialPos - BufferDelta
                    Seek #FileHandled, CorrectedPos
                    LCS = P_STREAMLENGTH - CorrectedPos
                    P_ATENDOFSTREAM = False
                    P_TEXT = MidB$(Buffer, 1, BufferMark)
                Else
                    P_LINEBREAK = vbNullString
                    LCS = P_STREAMLENGTH - InitialPos
                    P_ATENDOFSTREAM = False
                    P_TEXT = Buffer
                End If
            Case Else
                Buffer = Space$(LCS + 1)
                Get #FileHandled, , Buffer
                P_ATENDOFSTREAM = True
                P_TEXT = Buffer
        End Select
    End If
End Sub
Public Sub RestartPointer()
Attribute RestartPointer.VB_Description = "Moves the pointer to the text stream’s beginning position."
    If IsOpenStream Then
        Seek #FileHandled, 1
        StartVariables
    End If
End Sub
Public Sub SeekPointer(Position As Long)
Attribute SeekPointer.VB_Description = "Moves the pointer, over the target file, to the specified position."
    If Position > 0 Then
        If IsOpenStream Then
            Seek #FileHandled, Position
            CorrectedPos = Seek(FileHandled)
            LCS = P_STREAMLENGTH - CorrectedPos
            P_ATENDOFSTREAM = (P_STREAMLENGTH < CorrectedPos)
        End If
    End If
End Sub
Private Sub StartVariables()
    CorrectedPos = 0
    P_BUFFERLENGTH = CLng(P_BUFFERSIZE * SizeFactor)
    Buffer = Space$(P_BUFFERLENGTH)
    LCS = P_STREAMLENGTH
    P_ATENDOFSTREAM = False
End Sub
Public Sub WriteBlankLines(Lines As Long, Optional EndLineMark As EndLineChar = 0)
Attribute WriteBlankLines.VB_Description = "Inserts a specified number of blank lines into the current opened text file."
    If IsOpenStream Then
        Dim Idx As Long
        Select Case EndLineMark
            Case 0
                For Idx = 1 To Lines
                    Put #FileHandled, , vbCrLf
                Next Idx
            Case 1
                For Idx = 1 To Lines
                    Put #FileHandled, , vbCr
                Next Idx
            Case 2
                For Idx = 1 To Lines
                    Put #FileHandled, , vbLf
                Next Idx
        End Select
    End If
End Sub
Public Sub WriteText(ByRef TextData As String)
Attribute WriteText.VB_Description = "Writes the given string to the current opened text file."
    If IsOpenStream Then
        Put #FileHandled, , TextData
    End If
End Sub
'////////////////////////////////////////////////////////////////////////////////////////////
Private Sub Class_Initialize()
    P_BUFFERSIZE = 0.5
    P_BUFFERLENGTH = CLng(P_BUFFERSIZE * SizeFactor)
    P_ENDSTREAMONLINEBREAK = False
    Buffer = Space$(P_BUFFERLENGTH)
End Sub
Private Sub Class_Terminate()
    If IsOpenStream Then
        CloseStream
    End If
End Sub
