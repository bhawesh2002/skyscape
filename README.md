# SkyScape

SkyScape is a weather app built with Flutter that uses the OpenWeatherApi to fetch and display weather data. The app provides users with detailed weather information, including the current temperature, weather condition, humidity, wind speed, and visibility. SkyScape offers a range of features, such as default location setting, location-based weather retrieval, theme switching, temperature conversion, and search functionality, to enhance the user experience and provide valuable weather insights.

## Screenshots

### Light Theme
<div style="display: flex; flex-direction: row;">
  <img src="https://github.com/user-attachments/assets/fff3c142-6846-46bf-8eb4-38c4932d07c3" alt="Light Theme 1" style="width: 30%; margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/7a093dd4-b2e8-452a-85b6-64441f15de63" alt="Light Theme 2" style="width: 30%; margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/9033ac46-fb00-4d2f-b178-f459232ec7fb" alt="Light Theme 3" style="width: 30%;">
</div>

### Dark Theme
<div style="display: flex; flex-direction: row;">
  <img src="https://github.com/user-attachments/assets/02bfe5fd-a265-42f3-8c9e-387b7db9b4dc" alt="Dark Theme 1" style="width: 30%; margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/7a912823-599f-457f-817e-766ee0ba18b2" alt="Dark Theme 2" style="width: 30%; margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/333cf511-c5cf-443b-839c-93cd25fd2189" alt="Dark Theme 3" style="width: 30%;">
</div>

## Video

https://github.com/user-attachments/assets/215a0a88-7556-432c-aa3a-e1b329be8ff3

## Note
**Note:** In order to run the app, you need to obtain an API key from OpenWeatherApi. Once you have the API key, create a folder called `api_key` inside `lib` folder with `api_key.dart` file. This should be the path to the file containing apiKey: `lib/api_key/api_key.dart`

Add the following code to `api_key.dart` file:

```dart
const String apiKey = 'YOUR_API_KEY';
```

## Features

- **Weather Details**: SkyScape displays detailed weather information, including the current temperature, weather condition, humidity, wind speed, and visibility. By presenting comprehensive weather data, users can gain valuable insights into the current weather conditions and make informed decisions based on the information provided.

- **Default Location**: SkyScape allows users to set a default location for weather data retrieval. By specifying a default location, users can quickly access the weather information for their preferred location without having to manually enter the location each time they use the app.

- **Location-Based Weather**: SkyScape fetches weather data based on the user's geographical location, providing accurate and up-to-date weather information specific to the user's current location. This feature enhances the user experience by delivering personalized weather data tailored to the user's whereabouts.

- **Theme Switching**: SkyScape offers a light and dark theme, allowing users to switch between the two themes based on their preference. The app's theme is automatically set to dark mode when the device's system-wide dark mode is enabled, ensuring a consistent user experience.

- **Temperature Conversion**: SkyScape enables users to convert the temperature between Celsius and Fahrenheit by tapping on the temperature display. This feature provides users with the flexibility to view the weather data in their preferred temperature unit.

- **Search Functionality**: SkyScape allows users to search for weather information in any location by entering the desired location in the search bar. This feature enables users to access weather data for specific locations, making the app versatile and user-friendly.

## Packages Used

SkyScape utilizes several packages to enhance its functionality:

- **`shared_preferences`**: This package is used for storing user settings locally on the device. It allows the app to save and retrieve simple data types (such as strings, integers, and booleans) in a persistent storage, ensuring that user preferences are retained across app sessions.

- **`get`**: This package is employed for state management within the app. It simplifies the process of managing and updating the app's state, making it easier to build reactive user interfaces. `get` also provides dependency injection and route management, contributing to a more organized and maintainable codebase.

- **`geolocator`**: This package is used for accessing the device's location services to obtain the user's current coordinates. By fetching the user's geographical location, the app can provide weather information specific to the user's current location, enhancing the overall user experience.

- **`http`**: This package is utilized for making HTTP requests to the OpenWeatherApi to fetch weather data. It enables the app to retrieve weather information from the API and display it to the user in a structured format, ensuring that users have access to accurate and up-to-date weather data.

- **`flutter_svg`**: This package is used for rendering SVG images within the app. It allows the app to display vector graphics with high fidelity and resolution, enhancing the visual appeal of the user interface.

- **`is_first_run`**: This package is employed to determine whether the app is running for the first time on the user's device. By detecting the app's initial launch, SkyScape can provide users with an introductory onboarding experience to familiarize them with the app's features and functionality.

## Installation

To run SkyScape on your local machine, follow these steps:

1. Clone the repository using the following command:

```bash
git clone https://github.com/bhawesh2002/skyscape.git
```

2. Navigate to the project directory:

```bash
cd skyscape
```

3. Install the dependencies by running:

```bash
flutter pub get
```

4. Create a folder called `api_key` inside the `lib` folder and add an `api_key.dart` file with your OpenWeatherApi key:

```dart
const String apiKey = ' YOUR_API_KEY ';
```

5. Run the app on an emulator or physical device using the following command:

```bash
flutter run
```

By following these steps, you can set up and run SkyScape on your local machine to explore its features and functionality. The app provides users with detailed weather information, personalized weather data retrieval, theme switching, temperature conversion, and search functionality to enhance the user experience and deliver valuable weather insights.

## Folder Structure

The folder structure of SkyScape is organized as follows:

- **`lib`**: Contains the main source code for the app, including the Dart files that define the app's functionality and user interface.

  - **`api_key`**: Contains the `api_key.dart` file with the OpenWeatherApi key used for fetching weather data.

  - **`assets`**: Contains the assets used in the app, such as images and fonts.

    - **`city_list`**: Contains `owm_city_list.json` file with a list of cities and their geographical coordinates for location-based weather retrieval.

    - **`fonts`**: Contains the fonts used in the app for styling text elements.

    - **`images`**: Contains the images used in the app, such as icons and background images.

  - **`controllers`**: Contains the controller classes that manage the app's state and logic.

    - **`cities_list_controller.dart`**: Manages the list of cities displayed in the search results.
    - **`location_controller.dart`**: Manages the user's location and coordinates.
    - **`open_weather_controller.dart`**: Manages the weather data fetched from the OpenWeatherApi.
    - **`settings_controller.dart`**: Manages the user's settings and preferences.

  - **`pages`**: Contains the page classes that define the app's user interface and layout.

    - **`home.dart`**: Displays the main weather information and user interface elements.
    - **`cities_list_page.dart`**: Displays the search bar and search results for location-based weather retrieval.

  - **`routes`**: Contains the route configuration for the app's navigation and routing.

    - **`app_pages.dart`**: Defines the app's routes and page names for navigation.
    - **`app_routes.dart`**: Contains the route names and paths used for navigating between pages.

  - **`utils`**: Contains utility classes and functions used throughout the app.

    - **`enums`**: Contains the enums used in the app for defining constants and values.

    - **`measurements`**: Contains `UiSizes.dart` file with the values for height and width of the screen.

    - **`models`**: Contains the model classes used for data representation and serialization.

      - **`weather_models`**: Contains the weather model classes for representing weather data.

        - **`clouds.dart`**: Contains the model class for representing cloud data.
        - **`coord.dart`**: Contains the model class for representing geographical coordinates.
        - **`main_model.dart`**: Contains the model class for representing main weather data.
        - **`open_weather_model.dart`**: Contains the model class for representing weather data fetched from the OpenWeatherApi. It includes the main weather data, weather condition, wind data, and system data.
        - **`rain.dart`**: Contains the model class for representing rain data.
        - **`sys.dart`**: Contains the model class for representing system data.
        - **`weather.dart`**: Contains the model class for representing weather condition data.
        - **`wind.dart`**: Contains the model class for representing wind data.

      - **`owm_city.dart`**: Contains the model class for representing city data obtained from `owm_city_list.json`.
      - **`scapeuser.dart`**: Contains the model class for representing user data.
      - **`settings.dart`**: Contains the model class for representing user settings and preferences.

    - **`parsers`**: Contains the `parse_to_double.dart` file with the function to parse a int to double.

    - **`provider`**: Contains the files responsible for fetching weather data from the OpenWeatherApi and `owm_city_list.json`.

      - **`open_weather_provider.dart`**: Fetches weather data from the OpenWeatherApi.
      - **`owm_cities_list_provider.dart`**: Fetches city data from `owm_city_list.json`.

    - **`repository`**: Contains the repository classes that interact with the data providers and convert the data into appropriate models.
      - **`open_weather_repository.dart`**: Converts the weather data fetched from the provider into weather models.
      - **`owm_cities_list_repository.dart`**: Converts the city data fetched from the provider into city models.

## Acknowledgements

1. **Peter Schmalfeldt**:

   SkyScape uses [owm_city_list.json](https://github.com/manifestinteractive/openweathermap-cities/blob/master/data/owm_city_list.json) by [manifestinteractive](https://github.com/manifestinteractive) to provide location-based weather data retrieval. The owm_city_list.json file contains a list of cities with their corresponding geographical coordinates, enabling the app to fetch weather information based on the user's location. By leveraging this data, SkyScape allows user to search for cities and access weather data specific to their desired location.

   **Note:** I have modified the original file by changing the certain fields(keys) for my convenience and removed some unnecessary fields.

   Link to the repository: [openweathermap-cities](https://github.com/manifestinteractive/openweathermap-cities)
