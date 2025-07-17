<!DOCTYPE html>
<html lang="${locale!}">
<head>
  <meta charset="UTF-8"/>
  <title>${msg("Log In", "Login")}</title>
  <link rel="icon" href="${url.resourcesPath}/img/logo-ibis.png" type="image/png"/>
  <link rel="stylesheet" href="${url.resourcesPath}/css/mytheme.css"/>
</head>
<body>
  <div class="kc-app">
    <div class="kc-login-wrapper">
      <div class="kc-form-card">
        <div class="kc-header">
          <img src="${url.resourcesPath}/img/logo-ibis.png" alt="IBIS Management" class="logo"/>
        </div>
        <form id="kc-form-login" action="${url.loginAction}" method="post">
          <div class="kc-form-group">
            <label for="username">${msg("Username", "Username")}</label>
            <input id="username" name="username" type="text" autofocus="true"/>
          </div>
          <div class="kc-form-group">
            <label for="password">${msg("Password", "Password")}</label>
            <input id="password" name="password" type="password"/>
          </div>
          <div class="kc-form-actions">
            <button type="submit" class="kc-button">${msg("Log In", "Log In")}</button>
          </div>
        </form>
        <div class="kc-footer">
          <p>© ${.now?string("yyyy")} IBIS Management</p>
        </div>
      </div>
    </div>
  </div>
  <script src="${url.resourcesPath}/js/keycloak.js"></script>
</body>
</html>

