---
layout: default
title: Limitations
has_children: true
nav_order: 3
---

# ECPTextStream limitations
{: .fs-9 }

The ECPTextStream class module has the same limitations than the host application. Due the fact VBA uses the `Long` data Type on its file I/O functions, the *max amount of data that can be streamed is about 2 GB** (2,147,483,647 Bytes).

The above means, files with size over 2 GB isn’t allowed.