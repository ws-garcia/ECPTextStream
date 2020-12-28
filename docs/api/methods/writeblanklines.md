---
title: WriteBlankLines
parent: Methods
grand_parent: API
nav_order: 6
---

# WriteBlankLines
{: .fs-9 }

Inserts a specified number of blank lines into the current opened text file.
{: .fs-6 .fw-300 }

---

## Syntax

*expression*.`WriteBlankLines`*(Lines, \[EndLineMark\])*

### Parameters

<table>
<thead>
<tr>
<th style="text-align: left;">Part</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;"><em>Lines</em></td>
<td style="text-align: left;">Required. Identifier specifying a <code>Long</code> Type variable representing the number of blank lines to be inserted.</td>
</tr>
<tr>
<td style="text-align: left;"><em>EndLineMark</em></td>
<td style="text-align: left;">Optional. Identifier specifying a <code>EndLineChar</code> Enumeration constant representing the line break character to be inserted.</td>
</tr>
</tbody>
</table>

See also
: [EndLineChar Enumeration](https://ws-garcia.github.io/ECPTextStream/api/enumerations/endlinechar.html).

---

## Behavior

The `GetDataFromCSV` method returns an empty `String` when errors occurs.

[Back to Methods overview](https://ws-garcia.github.io/ECPTextStream/api/methods/)