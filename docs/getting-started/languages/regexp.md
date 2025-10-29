---
title: RegExp
---

# Regular Expressions

## Overview

A regular expression (shortened as regex or regexp) is a sequence of characters that define a search pattern. This can be used to search, parse and replace strings on which it is applied to. The expression itself is a language of itself and very powerful.

But the possibilities and interpretation of regular expressions depend strongly on the used engine. There are multiple engines having some common syntax but differ in many ways. Often the regular expression is put into delimiters like `/.../`. See the concrete language implementation therefore, but they sometimes can be changed.

The following will show the basics but for further information you may also look into: https://www.regular-expressions.info

## Syntax

Most characters are searched in the form they are in the expression but some which have special meaning have to be masked with an `\` before to not have their special meaning.

| Pattern | Example                              | Meaning                                                                 |
| ------- | ------------------------------------ | ----------------------------------------------------------------------- |
| `.m`    | 1. Ex<mark>am</mark>ple              | The `.` matches any character but not the newline and return character. |
| `\.m`   | 1<mark>.</mark> Example              | Match the `.` character.                                                |
| `e|a`   | 1. Ex<mark>a</mark>mpl<mark>e</mark> | Alternatives are written with a `|` between.                            |

### Special Characters

| Pattern  | Character                                                                                  |
| -------- | ------------------------------------------------------------------------------------------ |
| `\\`     | A masked `\` character to prevent the special meaning.                                     |
| `\t`     | Match a tabulator stop character.                                                          |
| `\r`     | Match a carriage return character.                                                         |
| `\n`     | Match a newline character.                                                                 |
| `\v`     | Match a vertical tabulator character.                                                      |
| `\f`     | Match a form feed character.                                                               |
| `\cX`    | Match a control character like `\cM`.                                                      |
| `\xHH`   | Match an ASCII character where `HH` is the hexadecimal number.                             |
| `\uHHHH` | Match an unicode character where `HHHH` is the hexadecimal number.                         |
| `[\b]`   | Match a backspace character (the brackets are necessary to not differ from word boundary). |
| `\<`     | Match the start of a word. (not supported in all engines)                                  |
| `\>`     | Match the end of a word. (not supported in all engines)                                    |

### Character Classes

!!! Info

    [] makes a character class matching any of the characters within

    [^] negative character class matching any not contained characters

| Pattern                                                | Example                              | Meaning                                                                                                                                                                                    |
| ------------------------------------------------------ | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `[^]`                                                  |                                      | Matches really any character, also the newline.                                                                                                                                            |
| `\d` or `[0-9]` or `[[:digit:]]`                       | <mark>1</mark>. Example              | Match any digit.                                                                                                                                                                           |
| `\D` or `[^0-9]`                                       | 1<mark>. Example</mark>              | Match any character but digits.                                                                                                                                                            |
| `[[:xdigit:]]` or `[A-Fa-f0-9]`                        |                                      | Hexadecimal digits                                                                                                                                                                         |
| `[[:ascii:]]` or `[\x00-\x7F]`                         |                                      | ASCII characters                                                                                                                                                                           |
| `[[:alpha:]]` or `[A-Za-z]`                            |                                      | Alphabetic characters                                                                                                                                                                      |
| `[[:alnum:]]` or `[A-Za-z0-9]`                         |                                      | Alphanumeric characters                                                                                                                                                                    |
| `\w` or `[A-Za-z0-9_]` or `[[:word:]]`                 | 1. <mark>Example</mark>              | Matches any alphanumeric character or the underscore.                                                                                                                                      |
| `\W` or `[^A-Za-z0-9_]`                                | <mark>1. </mark>Example              | Matches all characters which are not alphanumeric or underscore.                                                                                                                           |
| `[[:lower:]]` or `[a-z]`                               |                                      | Lowercase letters                                                                                                                                                                          |
| `[[:upper:]]` or `[A-Z]`                               |                                      | Uppercase letters                                                                                                                                                                          |
| `[[:cntrl:]]` or `[\x00-\x1F\x7F]`                     |                                      | Control characters                                                                                                                                                                         |
| `[[:graph:]]` or `[\x21-\x7E]`                         |                                      | Visible characters                                                                                                                                                                         |
| `[[:print:]]` or `[\x20-\x7E]`                         |                                      | Visible characters and the space character                                                                                                                                                 |
| `\s` or `[[:space:]]`                                  | 1.<mark> </mark>Example              | Matches all space like characters which are `[ \f\n\r\t\v​\u00a0\u1680​\u180e\u2000​\u2001\u2002​\u2003\u2004​ \u2005\u2006​\u2007\u2008​\u2009\u200a​\u2028\u2029​​\u202f\u205f​\u3000]`. |
| `\S`                                                   | <mark>1.</mark> <mark>Example</mark> | Opposite of `\s`.                                                                                                                                                                          |
| `[[:blank:]]` or `[ \t]`                               |                                      | Space and tab                                                                                                                                                                              |
| `[[:punct:]]` or `[][!"#$%&'()*+,./:;<=>?@\^_``{|}~-]` |                                      | Punctuation characters                                                                                                                                                                     |

### Boundaries

| Pattern | Example                 | Meaning                                                    |
| ------- | ----------------------- | ---------------------------------------------------------- |
| `^.`    | <mark>1</mark>. Example | Match only at the start of text with `^`.                  |
| `.$`    | 1. Exampl<mark>e</mark> | Match only at the end of text with `$`.                    |
| `\b`    |                         | Match a word boundary (before or after a word).            |
| `\B`    |                         | Match a only if no word boundary (before or after a word). |

### Quantifiers

| Pattern       | Example                                                 | Meaning                                                                                                  |
| ------------- | ------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `$\d*`        | in <mark>$</mark> it will cost <mark>$128</mark>        | The character before (here a digit) is matched 0 or multiple times.                                      |
| `$\d+`        | in $ it will cost <mark>$128</mark>                     | The character before (here a digit) has to match at least one times.                                     |
| `$\d?`        | in <mark>$</mark> it will cost <mark>$1</mark>28        | The character before (here a digit) is matched 0 or one time.                                            |
| `$\d*?`       | in <mark>$</mark> it will cost <mark>$</mark>128        | The character before (here a digit) is matched 0 or multiple times, but will match as less as possible.  |
| `$\d+?`       | in $ it will cost <mark>$1</mark>28                     | The character before (here a digit) has to match at least one times, but will match as less as possible. |
| `\b\d{2}\b`   | 1, <mark>10</mark>, 100, 1000                           | Match the character before exactly `num` times.                                                          |
| `\b\d{2,3}\b` | 1, <mark>10</mark>, <mark>100</mark>, 1000              | Match the character before between `min` and `max` times.                                                |
| `\b\d{2,}\b`  | 1, <mark>10</mark>, <mark>100</mark>, <mark>1000</mark> | Match the character before at least `min` times.                                                         |
| `\b\d{,2}\b`  | <mark>1</mark>, <mark>10</mark>, 100, 1000              | Match the character before not more than `max` times.                                                    |

In most engines regular expressions are greedy meaning they will match as much as possible. The last two matches will force a non-greedy use in which the interpretation will stop as soon as possible.

### Groups

They can be used to collect the match for later use or for limiting the alternation. Each group gets a number under which the match is stored. this is always the order in which the groups are opened.

| Pattern           | Example                                      | Meaning                                                                                                                                                        |
| ----------------- | -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `(...)`           | <mark>one</mark>, <mark>two</mark>, three    | Match all three character words and store them in variable `$1`.                                                                                               |
| `\b(a|an)\b`      | it's <mark>an</mark> old...                  | Thé group is used to make an alternation between a fixed pattern.                                                                                              |
| `(.)h\1`          | I here <mark>oho</mark> and <mark>aha</mark> | With back references using the group number the same match has to occur again.                                                                                 |
| `\b(?:a|an)\b`    | it's <mark>an</mark> old...                  | If a group starts with `?:` its match is not stored and counted as result (also called non-capturing or shy-group).                                            |
| `a(?>b|db)c`      | <mark>abcc</mark> or abc                     | The atomic non-capturing group will also forget the backtrack position. Here it will not take the second alternative into consideration if the first succeeds. |
| `(?<name>...)`    |                                              | Use named capturing groups which will store under it's number and given name.                                                                                  |
| `\k<name>`        |                                              | Make a back reference to a named capturing group.                                                                                                              |
| `\k<-1>`          |                                              | Relative back references go back to the group `num` steps.                                                                                                     |
| `(?|(a)|(b)|(c))` |                                              | Branch reset groups will be a non-capturing group which internal groups are not visible or counted to the outside.                                             |

### Look ahead/behind

| Pattern   | Meaning             | Description                                                    |
| --------- | ------------------- | -------------------------------------------------------------- |
| `x(?=y)`  | Positive Lookahead  | Matches `x`, but only if `y` will follow without capturing it. |
| `x(?!y)`  | Negative Lookahead  | Matches `x`, but only if not followed by `y`.                  |
| `x(?<=y)` | Positive Lookbehind | Matches `x`, but only if `y` will follow without capturing it. |
| `x(?<!y)` | Negative Lookbehind | Matches `x`, but only if not followed by `y`.                  |

### Specialities

| Pattern                 | Meaning      | Description                                                                                 |
| ----------------------- | ------------ | ------------------------------------------------------------------------------------------- |
| `(?R)`                  | Recursion    | Matches the complete regular expression at this point again.                                |
| `(?(?=regex)then|else)` | If-Then-Else | Based on `regex` is matched the expression `then` or `else` is evaluated.                   |
| `(?(1)then|else)`       | If-Then-Else | Based on numbered group (here `1`) is matched the expression `then` or `else` is evaluated. |

### Modifiers

The modifiers control the engine and are given behind the regular expression like `/a/i`.
Or in some languages also inline as `/(?i)a/`.

| Modifier | Meaning                                                                                                                                         |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `i`      | Case Insensitivity                                                                                                                              |
| `s`      | Dot matches also line breaks                                                                                                                    |
| `m`      | Multiline: `^` and `$` match on the start end end of line instead of complete text.                                                             |
| `x`      | Free spacing allows to write the regexp over multiple lines for inline documentation and readiness (but a space to match must be escaped `\ `). |

## Usage

In the POSIX standard, Basic Regular Syntax (BRE) requires that the metacharacters `(`, `)` and `{`, `}` be masked `\(\)` and `\{\}`, whereas Extended Regular Syntax (ERE) does not.

The most used expression is the Perl Regular Expression Syntax PCRE which is also used in Java, JavaScript, Python, .Net, Ruby and is also available in PHP.
