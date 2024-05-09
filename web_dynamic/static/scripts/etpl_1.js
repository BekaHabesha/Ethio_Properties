// Fetch real estate properties from the API
async function fetchProperties() {
  try {
    const response = await fetch('/properties');
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching properties:', error);
    return [];
  }
}

// Function to display the real estate properties in the HTML
async function displayProperties() {
  const propertyListDiv = document.getElementById("propertyList");

  // Clear any existing content
  propertyListDiv.innerHTML = "";

  // Fetch properties from the API
  const properties = await fetchProperties();

  // Loop through each property and create HTML elements to display them
  properties.forEach(property => {
    const propertyDiv = document.createElement("div");
    propertyDiv.className = "propertyItem";

    const titleHeading = document.createElement("h2");
    titleHeading.textContent = property.name;

    const locationPara = document.createElement("p");
    locationPara.textContent = "Location: " + property.location;

    const pricePara = document.createElement("p");
    pricePara.className = "types";
    pricePara.textContent = "Types: " + property.types;

    propertyDiv.appendChild(nameHeading);
    propertyDiv.appendChild(locationPara);
    propertyDiv.appendChild(typesPara);

    propertyListDiv.appendChild(propertyDiv);
  });
}

// Call the function to display properties when the page loads
window.onload = function() {
  displayProperties();
};