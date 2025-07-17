<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - First Global Bank</title>
  <link rel="icon" href="${url.resourcesPath}/img/fbg-logo.png" type="image/png"/>
  <link rel="stylesheet" href="${url.resourcesPath}/css/fbg-theme.css"/>
</head>
<body>
  <div class="login-container">
    <div class="login-header">
      <img src="${url.resourcesPath}/img/fbg-logo.png" alt="FGB Logo">
      <h1>Welcome to First Global Bank</h1>
    </div>

    <form action="${url.loginAction}" method="post">
      <input type="text" name="username" placeholder="Username" autofocus>
      <input type="password" name="password" placeholder="Password">
      <input type="submit" value="Login">
    </form>

    <div class="login-footer">
      <p>© ${.now?string("yyyy")} First Global Bank</p>
    </div>
  </div>
</body>
</html>

