import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

data = pd.read_csv(r"Wind_turbine.csv") # Read data into python

#EDA
data.dtypes
data.describe
data1 = data.dropna() # Remove rows and columns with missing values 
data2 = data.drop_duplicates() # Remove duplicate rows 
data1.info() #RangeIndex: 2900 entries, 0 to 2899,Data columns (total 16 columns)
data1.shape #Shows how many rows and columns

data1.Wind_speed # Shows all the data of wind_speed column

# FIRST Moment Business Decision:-
data1.Wind_speed.mean()
data1.Wind_speed.median()
data1.Wind_speed.mode()

# SECOND Moment Business Decision:-
data1.Wind_speed.var()
data1.Wind_speed.std()
range = max(data1.Wind_speed) - min(data1.Wind_speed)
range

# THIRD Moment Business Decision:-
data1.Wind_speed.skew()

# FOURTH Moment Business Decision:-
data1.Wind_speed.kurt()

#GRAPHS

#HISTOGRAM

plt.hist(data1.Wind_speed)
plt.hist(data1.Wind_speed, bins =  [5,10,15,20,25,30,35], color = 'green', edgecolor="red")

#DISTPLOT

sns.distplot(data1.Wind_speed)
sns.distplot(data1.Power)
#DISPLOT

sns.displot(data1.Wind_speed)
sns.displot(data1.Power)

#DENSITY PLOT
sns.kdeplot(data1.Wind_speed) # Density plot
sns.kdeplot(data1.Wind_speed, bw = 0.5 , fill = True)


# DATA PREPROCESSING

# Duplicates in Columns
# We can use correlation coefficient values to identify columns which have duplicate information
import pandas as pd

wind = pd.read_csv(r"Wind_turbine.csv")

# Correlation coefficient
'''
Ranges from -1 to +1. 
Rule of thumb says |r| > 0.85 is a strong relation
'''
wind.corr()
data1

### Outlier Treatment ###
import pandas as pd
import numpy as np
import seaborn as sns

df = data1
df.dtypes
df.shape
# Let's find outliers in Wind_speed 
sns.boxplot(df.Wind_speed)

# Detection of outliers (find limits for salary based on IQR)
IQR = df['Wind_speed'].quantile(0.75) - df['Wind_speed'].quantile(0.25)

lower_limit = df['Wind_speed'].quantile(0.25) - (IQR * 1.5)
upper_limit = df['Wind_speed'].quantile(0.75) + (IQR * 1.5)

###### 1. Remove (let's trim the dataset) #######
# Trimming Technique
# Let's flag the outliers in the dataset

outliers_df = np.where(df.Wind_speed > upper_limit, True, np.where(df.Wind_speed < lower_limit, True, False))

# outliers data
df_out = df.loc[outliers_df, ]

df_trimmed = df.loc[~(outliers_df), ]
df.shape, df_trimmed.shape

# Let's explore outliers in the trimmed dataset
sns.boxplot(df_trimmed.Wind_speed)

############### 2. Replace ###############
# Replace the outliers by the maximum and minimum limit
df['df_replaced'] = pd.DataFrame(np.where(df['Wind_speed'] > upper_limit, upper_limit, np.where(df['Wind_speed'] < lower_limit, lower_limit, df['Wind_speed'])))
sns.boxplot(df.df_replaced)

# Univariate Analysis
def univariate_analysis(data1, Wind_speed):
    plt.figure(figsize=(1, 6))
    
    # Histogram
    plt.subplot(2, 2, 1)
    sns.histplot(data1['Wind_speed'], kde=True)
    plt.title(f'Histogram of {"Wind_speed"}')
    
    # Boxplot
    plt.subplot(2, 2, 1)
    sns.boxplot(x=data1['Wind_speed'])
    plt.title(f'Boxplot of {"Wind_speed"}')


# Bivariate Analysis
def bivariate_analysis(data1, Power, Generator_speed):
    plt.figure(figsize=(1, 6))

    # Scatter plot
    plt.subplot(2, 2,4 )
    sns.scatterplot(x=data1['Power'], y=data1['Generator_speed'])
    plt.title(f'Scatter plot of {"Power"} vs {"Generator_speed"}')


    # Heatmap (for correlation matrix)
    if data1['Power'].dtype != 'O' and data1['Generator_speed'].dtype != 'O':
        plt.subplot(2, 2, 3)
        sns.heatmap(data1[['Power', 'Generator_speed']].corr(), annot=True, cmap='coolwarm', linewidths=.5)
        plt.title(f'Correlation Heatmap of {"Power"} and {"Generator_speed"}')

    plt.tight_layout()
    plt.show()

# Multivariate Analysis
def multivariate_analysis(data1):
    plt.figure(figsize=(12, 8))
    
    # Pairplot for all numerical variables
    sns.pairplot(data1, diag_kind='kde')
    plt.suptitle('Pairplot of Numerical Variables', y=1.02)
    plt.show()


# Correlation between columns
import numpy as np
import pandas as pd


# Read the data into a DataFrame
df = pd.read_csv(r"Wind_turbine.csv")

# Calculate the correlation matrix
correlation_matrix = df.corr()

# Print the correlation matrix
print(correlation_matrix)

# Based on the provided correlation matrix, the columns with strong positive correlations are:
# These are the results of correlation these all are not executable only for viewing.
* Power and Generator_speed (0.7400195231435036)
* Nacelle_ambient_temperature and Generator_bearing_temperature (0.5116844142230011)
* Generator_bearing_temperature and Generator_speed (0.7053626072218372)
* Gear_oil_temperature and Ambient_temperature (0.3045301288546987)
* Ambient_temperature and Rotor_Speed (0.581408347445363)
* Rotor_Speed and Nacelle_temperature (0.6773516333199493)
* Nacelle_temperature and Bearing_temperature (0.7179685948166531)
* Bearing_temperature and Generator_speed (0.6712544470606041)
* Gear_box_inlet_temperature and Power (0.7966810198727965)
* Gear_box_inlet_temperature and Generator_speed (0.5121555333333858)

These columns have correlation coefficients greater than 0.7, indicating a strong positive relationship between the variables. In other words, as one variable increases, the other variable also tends to increase.

The columns with strong negative correlations are:

* Wind_speed and Power (-0.5632648219797448)
* Wind_speed and Generator_bearing_temperature (-0.6627919169491758)
* Wind_speed and Gear_oil_temperature (0.13598020090249238)
* Wind_speed and Ambient_temperature (-0.474620219320327)
* Wind_speed and Rotor_Speed (-0.5764060942852989)
* Wind_speed and Nacelle_temperature (-0.6368001900403439)
* Wind_speed and Bearing_temperature (-0.6058225392095034)
* Wind_speed and Generator_speed (-0.5643320297114001)

These columns have correlation coefficients less than -0.7, indicating a strong negative relationship between the variables. In other words, as one variable increases, the other variable tends to decrease.

The remaining columns have correlation coefficients between -0.7 and 0.7, indicating moderate correlations between the variables.





