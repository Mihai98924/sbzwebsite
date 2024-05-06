from .local import *

# Try to import local settings, fallback to config via environment variables if that fails
try:
	from sbzwebsite.settings.local import *
except ImportError:
	from sbzwebsite.settings.environ import *
