GET http://localhost:8000/
HTTP 200
[Asserts]
xpath "string(//body/div/h1)" == "Hello, world!"

GET http://localhost:8000/hello
HTTP 200
[Asserts]
```
event: datastar-patch-elements
data: elements <h1 id="greeting">Hello, unknown!</h1>

```

GET http://localhost:8000/hello/bar
HTTP 200
[Asserts]
```
event: datastar-patch-elements
data: elements <h1 id="greeting">Hello, bar!</h1>

```

GET http://localhost:8000/api/hello/bar
HTTP 200
[Asserts]
{"greeting":"hello","name":"bar"}
