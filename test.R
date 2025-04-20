# Read in all three CSV files
all_causes <- read.csv("data/burden-of-disease-all-causes.csv")
cmnn <- read.csv("data/burden-of-disease-cmnn.csv")
ncd <- read.csv("data/burden-of-disease-ncd.csv")

# Examine the structure of each dataset
print("Structure of all_causes data:")
str(all_causes)

print("Structure of cmnn data:")
str(cmnn)

print("Structure of ncd data:")
str(ncd)

# Define regions and groupings to exclude
regions_to_exclude <- c(
    # Continents and major regions
    "Africa", "America", "Asia", "Europe", "Oceania",
    "North America", "Latin America and Caribbean", "Western Europe",
    "Eastern Europe", "Central Asia", "East Asia", "South Asia",
    "Southeast Asia", "Australasia", "Caribbean", "Central Europe",

    # Economic and development groupings
    "World", "G20", "European Union", "Commonwealth",
    "High SDI", "High-middle SDI", "Middle SDI", "Low-middle SDI", "Low SDI",
    "High-income", "World Bank High Income", "World Bank Low Income",
    "World Bank Lower Middle Income", "World Bank Upper Middle Income",
    "Commonwealth High Income", "Commonwealth Low Income", "Commonwealth Middle Income",
    "High-income Asia Pacific", "High-income North America",

    # Regional groupings
    "Andean Latin America", "Central Latin America", "Southern Latin America",
    "Tropical Latin America", "North Africa and Middle East",
    "South-East Asia Region", "African Region", "Region of the Americas",
    "Eastern Mediterranean Region", "European Region", "Western Pacific Region",
    "African Union", "Nordic Region", "OECD Countries",
    "Central Europe, Eastern Europe, and Central Asia",
    "Southeast Asia, East Asia, and Oceania",

    # Sub-regional groupings
    "Sub-Saharan Africa", "Western sub-Saharan Africa",
    "Eastern sub-Saharan Africa", "Central sub-Saharan Africa",
    "Southern sub-Saharan Africa",

    # World Bank regions
    "Latin America & Caribbean - World Bank region",
    "East Asia & Pacific - World Bank region",
    "Europe & Central Asia - World Bank region",
    "Middle East & North Africa",
    "South Asia - World Bank region",
    "Sub-Saharan Africa - World Bank region",

    # UK constituent countries (since UK is included)
    "England", "Scotland", "Wales", "Northern Ireland"
)

# Get unique countries from each dataset, excluding regions
all_causes_countries <- unique(all_causes$Entity[!all_causes$Entity %in% regions_to_exclude])
cmnn_countries <- unique(cmnn$Entity[!cmnn$Entity %in% regions_to_exclude])
ncd_countries <- unique(ncd$Entity[!ncd$Entity %in% regions_to_exclude])

# Find countries that appear in all three datasets
common_countries <- Reduce(intersect, list(all_causes_countries, cmnn_countries, ncd_countries))

# Sort the common countries alphabetically
common_countries <- sort(common_countries)

# Print the number of common countries
print(paste("Number of actual countries common to all datasets:", length(common_countries)))

# Print all common countries
print("All common countries:")
print(common_countries)

# Create subsets with only the common countries
all_causes_subset <- all_causes[all_causes$Entity %in% common_countries, ]
cmnn_subset <- cmnn[cmnn$Entity %in% common_countries, ]
ncd_subset <- ncd[ncd$Entity %in% common_countries, ]

# Verify the dimensions of our subsets
print("Dimensions of subsets:")
print(paste("all_causes subset:", nrow(all_causes_subset), "rows"))
print(paste("cmnn subset:", nrow(cmnn_subset), "rows"))
print(paste("ncd subset:", nrow(ncd_subset), "rows"))
