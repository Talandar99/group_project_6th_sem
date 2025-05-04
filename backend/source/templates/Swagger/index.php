<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="SwaggerUI" />
  <title>SwaggerUI</title>
  <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@5.11.0/swagger-ui.css" />
  <style>
    #swagger-ui .swagger-ui .scheme-container,
    body {
      background-color:rgb(27, 27, 27);
      color: white !important;
    }
    .swagger-ui p,
    .swagger-ui span,
    .swagger-ui h1,
    .swagger-ui h2,
    .swagger-ui h3,
    .swagger-ui h4,
    .swagger-ui h5,
    .swagger-ui h6,
    .swagger-ui td,
    .swagger-ui th,
    .swagger-ui .parameters-col_name * {
      color: white !important;
    }
    .swagger-ui .parameter__name.required span {
      color: red !important;
    }
    .swagger-ui .opblock .opblock-section-header {
      background-color: rgb(27, 27, 27);
      color: white !important;
    }
    .swagger-ui .info {
      margin: 50px 0 25px 0;
    }
  </style>
</head>
<body>
<div id="swagger-ui"></div>
<script src="https://unpkg.com/swagger-ui-dist@5.11.0/swagger-ui-bundle.js" crossorigin></script>
<script>
  window.onload = () => {
    window.ui = SwaggerUIBundle({
      url: '/swagger/api',
      dom_id: '#swagger-ui',
      defaultModelsExpandDepth: -1,
      defaultModelExpandDepth: -1,
      docExpansion: "none",
    });
  };
</script>
</body>
</html>