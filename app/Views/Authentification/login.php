<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authentification - Club Sportif</title>

    <!-- Ajouter le lien vers le fichier CSS de Tailwind -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 h-screen flex items-center justify-center">

<div class="bg-white p-8 rounded shadow-md w-96">
    <h2 class="text-2xl font-semibold mb-4 text-center">Espace Membre</h2>
    <?php if (isset($_GET['error']) && $_GET['error'] == 1): ?>
        <p style="color: red;">Erreur d'authentification. Veuillez vérifier vos informations de connexion.</p>
    <?php endif; ?>

    <form class="space-y-4" action="../../Controllers/AuthController.php" method="post">
        <div>
            <label for="email" class="block text-sm font-medium text-gray-600">Adresse Email</label>
            <input type="email" id="email" name="email"
                   class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:ring focus:border-blue-300">
        </div>

        <div>
            <label for="mot_de_passe" class="block text-sm font-medium text-gray-600">Mot de Passe</label>
            <input type="password" id="mot_de_passe" name="mot_de_passe"
                   class="mt-1 p-2 w-full border rounded-md focus:outline-none focus:ring focus:border-blue-300">
        </div>

        <button type="submit"
                class="w-full bg-blue-500 text-white p-2 rounded-md hover:bg-blue-600 focus:outline-none focus:ring focus:border-blue-300"  name="action">
            Se Connecter
        </button>
    </form>

    <div class="mt-6 p-4 bg-blue-50 border border-blue-200 rounded-md text-sm text-gray-700">
        <p class="font-semibold text-blue-700 mb-2">Accès démo</p>
        <p><span class="font-medium">Admin :</span> pierre.moreau@club.fr</p>
        <p><span class="font-medium">Mot de passe :</span> admin123</p>
    </div>

</div>

</body>

</html>
