# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (build-essential for some python packages)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install CPU-only PyTorch first (to save space/RAM)
RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu

# Copy requirements and install
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the backend code and chroma_db
# (Make sure chroma_db is populated if you want it to be part of the image)
COPY backend/ ./backend/
COPY chroma_db/ ./chroma_db/

# Set environment variables
ENV PYTHONPATH=/app/backend
ENV PORT=7860

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]

