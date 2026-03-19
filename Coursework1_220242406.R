#' title: Time Series CW1
#' author: Zayan Afzal
#' date: 13/03/2026

# Installing Project ------------------------------------------------------

install.packages("prophet")
library(prophet)

# Loading in my dataset (BitcoinTimeSeries) -------------------------------

data = read.csv("BitcoinTimeSeries.csv")
head(data)
names(data)
str(data)

# Setting up dataframe -----------------------------------------------------------------

bitcoin = data.frame(
    ds = as.Date(data$Time, format="%d/%m/%Y"),
    y = data$Bitcoin
)


# Checking if names updated -----------------------------------------------

head(bitcoin)
names(bitcoin)
str(bitcoin)

# Plotting ----------------------------------------------------------------

plot(bitcoin$ds, bitcoin$y,
     type="l",
     xaxt="n",
     xlab="Year",
     ylab="Search Interest",
     main="Google Search Trends for Bitcoin")


axis.Date(1,
          at=seq(min(bitcoin$ds),
                 max(bitcoin$ds),
                 by="1 year"),
          format="%Y")


# Prophet Forecast & Plot -------------------------------------------------

model = prophet(bitcoin)
future = make_future_dataframe(model,
                               periods=12,
                               freq="month")

forecast = predict(model, future)
plot(model, forecast)
