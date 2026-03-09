<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio - Facturación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3>Bienvenido al Sistema de Facturación</h3>
                    </div>
                    <div class="card-body">
                        <p>Has iniciado sesión correctamente.</p>
                        <p>Token guardado en localStorage: <code id="token"></code></p>
                        <p>Usuario: <code id="user"></code></p>
                        <hr>
                        <a href="http://localhost:8000/dashboard" class="btn btn-primary">Ir al Dashboard</a>
                        <button onclick="logout()" class="btn btn-danger">Cerrar Sesión</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Mostrar datos del usuario
        const token = localStorage.getItem('auth_token');
        const userData = localStorage.getItem('user_data');
        
        document.getElementById('token').textContent = token ? token.substring(0, 20) + '...' : 'No encontrado';
        document.getElementById('user').textContent = userData ? JSON.parse(userData).email : 'No encontrado';

        function logout() {
            localStorage.removeItem('auth_token');
            localStorage.removeItem('user_data');
            localStorage.removeItem('empresas');
            window.location.href = 'http://localhost/demo/public_html/CYM/login.php';
        }
    </script>
</body>
</html>
