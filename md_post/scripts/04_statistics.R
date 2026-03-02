#!/usr/bin/env Rscript

# Create output folder
dir.create("outputs/statistics", showWarnings = FALSE, recursive = TRUE)

systems <- list.dirs("outputs", recursive = FALSE, full.names = TRUE)
systems <- systems[systems != "outputs/statistics"]

read_xvg <- function(path) {
  lines <- readLines(path)
  lines <- lines[!grepl("^@|^#", lines)]
  data <- read.table(text = lines)
  return(data)
}

metrics <- c("rmsd","rmsf","sasa","hbond","rg")

results <- data.frame()

for (metric in metrics) {
  combined <- data.frame()

  for (sys in systems) {
    sys_name <- basename(sys)
    file_path <- paste0(sys, "/", metric, "/", metric, ".xvg")

    if (file.exists(file_path)) {
      df <- read_xvg(file_path)
      values <- df[,2]
      temp <- data.frame(System=sys_name, Value=values)
      combined <- rbind(combined, temp)
    }
  }

  if (nrow(combined) > 0) {
    kw <- kruskal.test(Value ~ System, data=combined)

    results <- rbind(results,
                     data.frame(Metric=metric,
                                p_value=kw$p.value))
  }
}

write.csv(results, "outputs/statistics/kruskal_results.csv", row.names=FALSE)

cat("Statistics completed.\n")
