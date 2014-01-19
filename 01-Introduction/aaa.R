# ufo_sightings.R for R ver. 3.

# ヘッダーなしデータ読み込み
ufo <- read.delim("../ML_for_Hackers/01-Introduction/data/ufo/ufo_awesome.tsv",
                  header=FALSE,
                  stringsAsFactors=FALSE, # スペル間違いのため使われていない引数になっていたので修正して追加
                  na.strings = "")
# ヘッダー設定
names(ufo) <- c("DateOccurred", 
                "DateReported", 
                "Location", 
                "ShortDescription", 
                "Duration", 
                "LongDescription")

# 日付フォーマットできるように対象を制限の設定する
good.rows <- ifelse(nchar(ufo$DateOccurred) != 8 | nchar(ufo$DateReported) != 8, 
# good.rows <- ifelse(nchar(as.character(ufo$DateOccurred)) != 8 | nchar(as.character(ufo$DateReported)) != 8, 
                    FALSE, 
                    TRUE)

# 制限したデータフレームをあつかうために代入する
ufo <- ufo[good.rows,]

# フォーマット出来るデータ形式のみに制限したので、実際にフォーマットする
ufo$DateOccurred <- as.Date(ufo$DateOccurred, format="%Y%m%d")
ufo$DateReported <- as.Date(ufo$DateReported, format="%Y%m%d")

# 位置情報の都市名＋州名を満たさないものをNAにして返す
get.location <- function(l) {
  split.location <- tryCatch(strsplit(l, ",")[[1]], error= function(e) return(c(NA, NA)))
  clean.location <- gsub("^ ", "", split.location)
  if (length(clean.location) > 2) {
    return(c(NA, NA))
  } else {
    return(clean.location)
  }
}

# 
