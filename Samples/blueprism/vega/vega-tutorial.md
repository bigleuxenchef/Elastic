# Vega tutorial : complete example

# Link the json to Vega

```json
  "$schema": "https://vega.github.io/schema/vega/v3.json",
```

## Feeding the data into Vega




### Define the axis scale in relation to the data set
 

## Configured grid

```json
 
"config": {
    "axis": {
        "grid": true, # true or false will show or hide the grid
        "tickSize": 10, # define the length of the tick on the axis
        "labelFont": "Monaco, Courier New",
        "titleFont" : "Monaco, Courier New",
        "titleFontSize": 18,
        "titlePadding" : 5 # define the distance between the title and the axis
  }
  ```


## Offset the axis and adding title

```json
# adding offset allows axis to bbe cleaner and not overlapping chart content
 axes": [
    {"scale": "xscale", "orient": "bottom", "offset": {"value": 20}, "title": "Timeline"},
    {"scale": "yscale", "orient": "left", "offset": {"value": 20}, "title": "Number of Processes"}
  ]
```
