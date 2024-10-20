document.getElementById('login-form').addEventListener('submit', (event) => {
    event.preventDefault(); 

    const username = document.querySelector('#login-form input[type="text"]').value;
    const password = document.querySelector('#login-form input[type="password"]').value;

    // Hardcoded credentials
    const validUsername = "Maleesha";
    const validPassword = "1234abcd";

    if (username === validUsername && password === validPassword) {
        //alert('Login successful!');
        window.location.href = 'index.html'; 
    } else {
        alert('Invalid username or password.');
    }
});

document.getElementById('register-form').addEventListener('submit', async (event) => {
    event.preventDefault(); 

    const username = document.querySelector('#register-form input[type="text"]').value;
    const password = document.querySelector('#register-form input[type="password"]').value;
    const email = document.querySelector('#register-form input[type="email"]').value;

    try {
        const response = await fetch('http://localhost:8080/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json' 
            },
            body: JSON.stringify({ username, password, email }) 
        });

        const result = await response.json(); 
        alert(result.message); 

    } catch (error) {
        console.error('Error:', error);
        alert('Failed to register');
    }
});

document.getElementById('toggleForm').addEventListener('click', (e) => {
    e.preventDefault(); 

    const loginForm = document.getElementById('login-form');
    const registerForm = document.getElementById('register-form');
    const toggleText = document.getElementById('toggleForm');

    if (loginForm.style.display === 'none') {
        loginForm.style.display = 'block';
        registerForm.style.display = 'none';
        toggleText.textContent = "Register"; 
    } else {
        loginForm.style.display = 'none';
        registerForm.style.display = 'block';
        toggleText.textContent = "Login"; 
    }
});
