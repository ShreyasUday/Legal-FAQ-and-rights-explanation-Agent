# Use the official Python version
FROM python:3.10-slim

# Set the working directory 
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the backend code
COPY . .

# Expose the standard Hugging Face port
EXPOSE 7860

# Run the backend on port 7860
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]