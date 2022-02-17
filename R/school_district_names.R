library(readxl)

va_school_districts <- read_excel("data/ncesdata_72022347.xlsx",
                                  skip = 12)
md_school_districts <- read_excel("data/ncesdata_EFC0DD2E.xlsx",
                                  skip = 12)
dc_school_districts <- read_excel("data/ncesdata_BCEDBAEF.xlsx",
                                  skip = 12)

