module Android

  module Geolocation

    module_function

    def start
    end

    # Return hash of current values from screen
    def values
      { latitude: value_of('Lat'), longitude: value_of('Lng') }
    end

    def update_position
      driver.find_elements(css: 'button').last.click
    end

    # get text field from all 'h1' elements in DOM
    def get_all_h1
      driver.find_elements(css: 'h1').map { |t| t.text }
    end

    # Parses strings from Coordinates in screen
    # (in the format: "Lat: -34.82532333333334")
    # and return only the value as string
    def value_of(position)
      get_all_h1.find{ |e| e.include?(position) }.split.last
    end

  end

end
