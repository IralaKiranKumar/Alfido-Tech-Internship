import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn.preprocessing import LabelEncoder

# Load your Excel file (adjust path if needed)
file_path = path = "C:/Users/kiran/comments.csv - Copy.xlsx"

df = pd.read_excel(file_path, sheet_name="comments")

# Clean up column names
df.columns = df.columns.str.strip()

# Convert date/time columns
df['created Timestamp'] = pd.to_datetime(df['created Timestamp'], errors='coerce')
df['posted date'] = pd.to_datetime(df['posted date'], errors='coerce')

# Convert hashtag count to numeric
df['Hashtags used count'] = pd.to_numeric(df['Hashtags used count'], errors='coerce')

# 1. Comments per User
plt.figure(figsize=(10, 5))
df['User  id'].value_counts().plot(kind='bar')
plt.title('Number of Comments per User')
plt.xlabel('User ID')
plt.ylabel('Comment Count')
plt.tight_layout()
plt.show()

# 2. Hashtag Usage Distribution
plt.figure(figsize=(8, 5))
plt.hist(df['Hashtags used count'].dropna(), bins=10, edgecolor='black')
plt.title('Hashtag Usage Distribution')
plt.xlabel('Hashtag Count')
plt.ylabel('Frequency')
plt.tight_layout()
plt.show()

# 3. Emoji Usage (Pie Chart)
emoji_counts = df['emoji used'].value_counts()
plt.figure(figsize=(6, 6))
plt.pie(emoji_counts, labels=emoji_counts.index, autopct='%1.1f%%', startangle=140)
plt.title('Emoji Usage')
plt.tight_layout()
plt.show()

# 4. Comment Frequency Over Time
daily_comments = df.set_index('created Timestamp').resample('D').size()
plt.figure(figsize=(12, 6))
daily_comments.plot()
plt.title('Daily Comment Frequency')
plt.xlabel('Date')
plt.ylabel('Comment Count')
plt.tight_layout()
plt.show()

# 5. Correlation Heatmap
df_encoded = df.copy()
le = LabelEncoder()
df_encoded['emoji used'] = le.fit_transform(df_encoded['emoji used'].astype(str))
numeric_df = df_encoded[['User  id', 'Photo  id', 'emoji used', 'Hashtags used count']].dropna()
corr_matrix = np.corrcoef(numeric_df.T)

plt.figure(figsize=(8, 6))
plt.imshow(corr_matrix, cmap='coolwarm', interpolation='none')
plt.colorbar()
plt.xticks(ticks=range(len(numeric_df.columns)), labels=numeric_df.columns, rotation=45)
plt.yticks(ticks=range(len(numeric_df.columns)), labels=numeric_df.columns)
plt.title('Correlation Heatmap')
plt.tight_layout()
plt.show()
