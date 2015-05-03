## file structure

if (! file.exists("data")) dir.create("data")

if (!file.exists("data/surveys.csv")) {
  download.file("http://files.figshare.com/1919744/surveys.csv",
                "data/surveys.csv")
}

if (!file.exists("data/species.csv")) {
  download.file("http://files.figshare.com/1919741/species.csv",
                "data/species.csv")
}

if (!file.exists("data/plots.csv")) {
  download.file("http://files.figshare.com/1919738/plots.csv",
                "data/plots.csv")
}

if (!file.exists("data/messy_survey_data.csv")) {
  download.file("http://sorvivalas.com/temp/messy_survey_data.csv",
                "data/messy_survey_data.csv")
}

if (!file.exists("data/pivot_survey_data.csv")) {
  download.file("http://sorvivalas.com/temp/pivot_survey_data.csv",
                "data/pivot_survey_data.csv")
}
