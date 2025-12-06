// Variable global para almacenar el ID del usuario
let userId = null; 

// URL base
const API_BASE_URL = 'http://127.0.0.1:8000';

// Función para registrar o identificar al usuario
async function registerUser() {
    const userEmail = document.getElementById('user-name').value.trim();
    const statusMessage = document.getElementById('user-status');
    
    if (!userEmail) {
        statusMessage.textContent = 'Por favor, introduce tu nombre.';
        return;
    }

    try {
        // Llama al endpoint de login POST /users/login
        const response = await fetch(`${API_BASE_URL}/users/login?email=${userEmail}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        const data = await response.json();

        if (response.ok) {
            userId = data.id; // Guarda el ID del nuevo usuario
            statusMessage.textContent = `¡Bienvenido, ${data.nombre}! Tu ID es: ${userId}`;
            
            // Oculta la sección de registro y muestra la de selección
            document.getElementById('user-section').classList.add('hidden');
            document.getElementById('selection-section').classList.remove('hidden');
            
            // Carga la lista de cursos disponibles
            await loadAvailableCourses(data.historial);
        } else {
            statusMessage.textContent = `Error al registrar: ${data.detail || response.statusText}`;
        }
    } catch (error) {
        statusMessage.textContent = `Error de conexión con el API: ${error.message}`;
        console.error('Error:', error);
    }
}

// Función auxiliar para obtener la lista completa de cursos desde el API
async function getAvailableCoursesFromAPI() {
    try {
        // Llama al nuevo endpoint GET /cursos_todos
        const response = await fetch(`${API_BASE_URL}/cursos`); 
        if (response.ok) {
            return await response.json();
        }
    } catch (error) {
        console.warn('Endpoint /cursos_todos no accesible. Usando lista estática.');
    }
}

// Función para cargar los checkboxes en la interfaz
async function loadAvailableCourses(historial) {
    const coursesListDiv = document.getElementById('courses-list');
    const recommendButton = document.getElementById('recommend-button');
    coursesListDiv.innerHTML = '';
    
    const courses = await getAvailableCoursesFromAPI();
    courses.forEach(course => {
        const item = document.createElement('div');
        item.className = 'course-item';
        const isInHistorial = historial.includes(course.codigo);
        item.innerHTML = `
            <input type="checkbox" id="${course.codigo}" value="${course.codigo}" ${isInHistorial ? 'checked disabled' : ''}>
            <label for="${course.codigo}">${course.codigo} - ${course.nombre}</label>
        `;
        coursesListDiv.appendChild(item);
    });

    recommendButton.disabled = false; // Habilita el botón una vez cargado
}

// Función principal: guarda el historial y pide la recomendación
async function saveAndRecommend() {
    if (!userId) {
        alert('Error: Debes iniciar sesión primero.');
        return;
    }

    const approvedCourses = Array.from(document.querySelectorAll('#courses-list input:checked:not(:disabled)'))
                               .map(checkbox => checkbox.value);

    if (approvedCourses.length === 0) {
        alert('Por favor, selecciona al menos un curso aprobado.');
        return;
    }

    const resultsContainer = document.getElementById('recommendations-container');
    resultsContainer.innerHTML = 'Cargando recomendaciones... Esto puede tardar unos segundos (llamada a la IA)...';
    document.getElementById('results-section').classList.remove('hidden');

    // GUARDAR LOS NUEVOS CURSOS UNO POR UNO (Se asume que es el historial completo del usuario)
    for (const courseCode of approvedCourses) {
        await fetch(`${API_BASE_URL}/users/${userId}/historial?codigo_curso=${courseCode}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        });
    }

    // OBTENER LAS RECOMENDACIONES DE LA BD/PROLOG/IA
    try {
        const response = await fetch(`${API_BASE_URL}/recomendar_db`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ user_id: userId })
        });

        const data = await response.json();
        
        if (response.ok && data.status === 'success') {
            displayRecommendations(data.recomendaciones);
        } else {
            resultsContainer.innerHTML = `<p style="color: red;">Error en la recomendación: ${data.mensaje || response.statusText}</p>`;
        }
    } catch (error) {
        resultsContainer.innerHTML = `<p style="color: red;">Error de red al consultar el API.</p>`;
        console.error('Error:', error);
    }
}

// Función para mostrar los resultados en la interfaz
function displayRecommendations(recommendations) {
    const container = document.getElementById('recommendations-container');
    container.innerHTML = '';

    if (recommendations.length === 0) {
        container.innerHTML = '<p>¡Felicidades! Has completado todos los cursos elegibles o no hay rutas válidas con tus aprobados.</p>';
        return;
    }

    recommendations.forEach(rec => {
        const card = document.createElement('div');
        card.className = 'recommendation-card';
        card.innerHTML = `
            <h3>${rec.nombre} (${rec.codigo})</h3>
            <p><strong>Explicación de la IA:</strong> ${rec.explicacion_enriquecida}</p>
        `;
        container.appendChild(card);
    });
}