document.getElementById('filter-btn').addEventListener('click', function () {
    const date = document.getElementById('date-filter').value;
    const location = document.getElementById('location-filter').value;

    // Fetch events from the backend (Ballerina service).
    fetch('http://localhost:8080/events')
        .then(response => response.json())
        .then(events => {
            const eventsGrid = document.getElementById('events-grid');
            eventsGrid.innerHTML = ''; // Clear previous content.

            // Filter events based on user input.
            const filteredEvents = events.filter(event => {
                return (!date || event.date === date) && (!location || event.location.includes(location));
            });

            // Update the grid with filtered events.
            filteredEvents.forEach(event => {
                const eventDiv = document.createElement('div');
                eventDiv.className = 'event';
                eventDiv.textContent = `${event.name} - ${event.location} (${event.date})`;
                eventsGrid.appendChild(eventDiv);
            });
        })
        .catch(error => console.error('Error fetching events:', error));
});
