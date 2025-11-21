#!/bin/bash

echo "===== Django Deployment Script ====="

# Stop on any error
set -e

# 1. Create virtual environment if not exists
if [ ! -d "env" ]; then
    echo "Creating virtual environment..."
    python3 -m venv env
else
    echo "Virtual environment already exists."
fi

# 2. Activate virtual environment
echo "Activating virtual environment..."
source env/bin/activate

# 3. Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# 4. Install requirements
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
else
    echo "requirements.txt not found!"
    exit 1
fi

# 5. Run migrations
echo "Running migrations..."
python manage.py migrate

# 6. Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "===== Deployment Complete ====="
