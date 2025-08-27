FROM python:3.9

WORKDIR /app/backend

# Environment variable for Django settings
ENV DJANGO_SETTINGS_MODULE=notesapp.settings

# Install dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

# Carry project files into container
COPY . /app/backend

# Apply database migrations
RUN python /app/backend/manage.py makemigrations
RUN python /app/backend/manage.py migrate

# Expose port 8000
EXPOSE 8000

# Start the development server
CMD ["python", "/app/backend/manage.py", "runserver", "0.0.0.0:8000"]
