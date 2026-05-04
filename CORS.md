# Cross Origin Resource Sharing (CORS)

Origin: domain + protocol + port

CORS is a browser security mechanism that controls how a web page from one
origin can request resources from a different origin.

For example, the web UI is fetched from the front-end server
`https://example.com`, and the JS is trying to call an API at
`https://api.other.com`.

By default, browsers block many of these cross-origin requests unless the UI
front-end server explicitly allows them using CORS headers.

CORS exists mainly as a protection against malicious websites making
unauthorized requests to another site where you might be logged in (for
example, stealing data or performing actions on your behalf).

CORS isn't about who can send requests, it's about who is allowed to read the
response in a browser. Browsers do not generally block sending cross-origin
requests. They block JavaScript from accessing the response unless the server
says it's okay.

A request may still happen. But the malicious website can't see the result.
CORS protects data leakage, not state-changing actions.
CORS is designed to stop data theft, not action execution.

To protect against JS from evil.com sending a request to bank.com, rely on CSRF.

CORS headers:

* `Access-Control-Allow-Origin`: tells the browser which origins are allowed to
  access the resource.

  It answer the question: "Which origins are allowed to read this response?".

  For example, JS from origin X makes a request (fetch/XHR) to origin Y, and
  origin Y returns a response along with an `Access-Control-Allow-Origin`
  header. If the origin X is allowed in that header, JS can access the response.

  Because the server owns the data, so it decides: "Which external origins am I
  willing to share this data with?"

  Special case: `Access-Control-Allow-Origin: *`. Allows any origin (public
  access). Not allowed for requests with credentials (cookies/auth headers).

* `Access-Control-Allow-Methods`: specifies which HTTP methods are allowed when
  accessing the resource cross-origin.

  The browser is allowed to send those methods in cross-origin requests.

* `Access-Control-Allow-Headers`: defines which request headers the browser is
  allowed to include in a cross-origin request.

  Without this, the browser may block the request if you try to send custom or
  non-simple headers.

## pre-flight

For "non-simple" requests (e.g. using PUT, DELETE, or custom headers), the
browser first sends a preflight request:

```
OPTIONS /api/resource
Origin: https://example.com
Access-Control-Request-Method: PUT
Access-Control-Request-Headers: Authorization
```

The server responds with CORS headers like:

```
Access-Control-Allow-Origin: https://example.com
Access-Control-Allow-Methods: PUT
Access-Control-Allow-Headers: Authorization
```

If the browser is satisfied, it then sends the real request.

