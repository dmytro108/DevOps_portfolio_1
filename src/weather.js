// API Key for WeatherAPI.com
const apiKey = 'ef2d5dd72aa94e44a73155448231105';

// Function to fetch the weather data from WeatherAPI.com
async function fetchWeatherData(city) {
  try {
    const response = await fetch(`https://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${city}`);
    const data = await response.json();
    return data;
  } catch (error) {
    console.log('Error fetching weather data:', error);
  }
}

// Function to display the weather information on the webpage
function displayWeatherData(data) {
    const weatherDiv = document.getElementById('weather');
    const location = data.location.name;
    const temp = data.current.temp_c;
    const condition = data.current.condition.text;
    const upd = data.current.last_updated;
    const cond_img = data.current.condition.icon;
    const wind_speed = data.current.wind_kph;
    const wind_dir = data.current.wind_dir;
    const hum = data.current.humidity;
    const pres = data.current.pressure_mb;
  
    weatherDiv.innerHTML = `<!-- <h1>Weather in ${location}</h1> -->
                            <i>Updated: ${upd}</i>
                             <table border=0>
                             <tr>
                              <td>
                                <h2>${temp}&deg;C</h2>
                              </td><td>
                                <img src="http:${cond_img}" style="vertical-align:bottom">
                              </td><td>
                                <!-- ${condition}<br> -->
                                Wind: ${wind_dir}, ${wind_speed} km/h<br>
                                Humidity: ${hum}%<br>
                                Pressure: ${pres} mb
                              </td>
                             </tr>
                             </table>`;
  }

  // Fetch weather data and display it when the page loads
window.addEventListener('load', async () => {
    const citySelect = document.getElementById('citySelect');
    const selectedCity = citySelect.value;
  
    const weatherData = await fetchWeatherData(selectedCity);
    displayWeatherData(weatherData);
  });
  
  // Update weather data and display when a different city is selected
  document.getElementById('citySelect').addEventListener('change', async () => {
    const citySelect = document.getElementById('citySelect');
    const selectedCity = citySelect.value;
  
    const weatherData = await fetchWeatherData(selectedCity);
    displayWeatherData(weatherData);
  });
  