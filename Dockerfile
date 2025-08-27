FROM python:3.9

WORKDIR /app/backend

# Environment variable pointing to the settings module
ENV DJANGO_SETTINGS_MODULE=settings

# Upgrade base packages and install dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Carry project files into container
COPY . /app/backend

# Apply database migrations during build phase
RUN python /app/backend/manage.py makemigrations
RUN python /app/backend/manage.py migrate

# Expose port 8000 for the application
EXPOSE 8000

# Run Django application
CMD python /app/backend/manage.py runserver 0.0.0.0:8000
