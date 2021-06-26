---
title: linebreakMatchingBehavior
parent: Properties
grand_parent: API
nav_order: 8
---

# linebreakMatchingBehavior
{: .d-inline-block }

New
{: .label .label-purple }

Gets or sets the behavior of line break matching in subsequent text stream operations.
{: .fs-6 .fw-300 }

---

## ReadWrite

_Yes_

---

## Syntax

|**_Accesor_**|**_Syntax_**|
|:----------|:----------|
|Get|*expression*.`linebreakMatchingBehavior`|
|Let|*expression*.`linebreakMatchingBehavior` = value|

|**_Accesor_**|**_Parameters_**|
|:----------|:----------|
|Get|_None_|
|Let|*Name*: Value<br>*Type*: `EndLineMatchingBehavior`<br>*Modifiers*: `ByVal`|

|**_Accesor_**|**_Returns Type_**|
|:----------|:----------|
|Get|`EndLineMatchingBehavior`|
|Let|_None_|

## Behavior

The `linebreakMatchingBehavior` property allows the user to specify how line breaks are searched for to end the current buffer in vbCrLf, vbCr or vbLf as specified in the `endStreamOnLineBreak` property. By default, the `linebreakMatchingBehavior` property is set to `EndLineMatchingBehavior.Bidirectional`, this option ensures the handling of files with long lines that cannot be contained in a string of specified size as in the `bufferSize` property. 

>⚠️**Caution**
>{: .text-grey-lt-000 .bg-green-000 }
>Setting the `linebreakMatchingBehavior` property to `EndLineMatchingBehavior.OnlyBackwardSense` may cause unexpected behavior when the stream is requested to end at a line break and the current text stream contains a portion of a long line that cannot be stored in the specified buffer size.
{: .text-grey-dk-300 .bg-yellow-000 }

See also
: [EndStreamOnLineBreak Property](https://ws-garcia.github.io/ECPTextStream/api/properties/endstreamonlinebreak.html), [EndLineMatchingBehavior Enumeration](https://ws-garcia.github.io/ECPTextStream/api/enumerations/endlinematchingbehavior.html), [BufferSize Property](https://ws-garcia.github.io/ECPTextStream/api/properties/buffersize.html).

---

[Back to Properties overview](https://ws-garcia.github.io/ECPTextStream/api/properties/)