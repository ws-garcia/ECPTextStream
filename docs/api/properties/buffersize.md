---
title: BufferSize
parent: Properties
grand_parent: API
nav_order: 3
---

# BufferSize
{: .fs-9 }

Gets or sets the buffer’s size, in MB, for text stream operations.
{: .fs-6 .fw-300 }

---

## ReadWrite

_Yes_

---

## Syntax

|**_Accesor_**|**_Syntax_**|
|:----------|:----------|
|Get|*expression*.`BufferSize`|
|Let|*expression*.`BufferSize` = value|

|**_Accesor_**|**_Parameters_**|
|:----------|:----------|
|Get|_None_|
|Let|*Name*: Value<br>*Type*: `Single`<br>*Modifiers*: `ByVal`|

|**_Accesor_**|**_Returns Type_**|
|:----------|:----------|
|Get|`Single`|
|Let|_None_|

>📝**Note**
>{: .text-grey-lt-000 .bg-green-000 }
>The `BufferSize` enable user to specify how many data is read at a time. By default, the `BufferSize` property is set to 0.5 MB (512 KB). For files holding very long lines, user must to choose a size enough to hold couple of lines at once.
{: .text-grey-dk-300 .bg-grey-lt-000 }

See also
: [ReadText Method](https://ws-garcia.github.io/ECPTextStream/api/methods/readtext.html), [BufferLen Property](https://ws-garcia.github.io/ECPTextStream/api/properties/bufferlen.html).

---

[Back to Properties overview](https://ws-garcia.github.io/ECPTextStream/api/properties/)