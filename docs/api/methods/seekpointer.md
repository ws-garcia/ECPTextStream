---
title: SeekPointer
parent: Methods
grand_parent: API
nav_order: 5
---

# SeekPointer
{: .fs-9 }

Moves the pointer, over the target file, to the specified position.
{: .fs-6 .fw-300 }

---

## Syntax

*expression*.`SeekPointer`*(Position)*

### Parameters

The required *Position* argument is an identifier specifying a `Long` type variable.

### Return value

_None_

>📝**Note**
>{: .text-grey-lt-000 .bg-green-000 }
>The next read operation will start in the position specified with the `SeekPointer` method. 
{: .text-grey-dk-300 .bg-grey-lt-000 }

See also
: [RestartPointer method](https://ws-garcia.github.io/ECPTextStream/api/methods/restartpointer.html).

---

[Back to Methods overview](https://ws-garcia.github.io/VBA-CSV-interface/api/methods/)
