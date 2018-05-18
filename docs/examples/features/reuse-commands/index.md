# Re-use a Common Set of Commands

The nice thing about Make is that you can re-use targets without worrying about
them getting run twice. This means you can safely specify build dependencies.
For example consider the following Makefile:

[import, lang:"makefile", template:"ace"](Makefile)

---

You might think that calling `make tugboat-init` on the above Makefile would
result in:

```
foo
foo
bar
baz
```

But make knows that it's already run the foo target, so you actually get:

```
foo
bar
baz
```
