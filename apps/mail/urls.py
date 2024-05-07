from django.urls import re_path as url

from apps.mail import views

app_name = 'mail'

urlpatterns = [
    url('^$', view=views.index, name='index'),
    url('^sync/$', view=views.sync, name='sync'),
    url('^group/$', view=views.group_create, name='group_create'),
    url('^group/(?P<pk>[0-9]+)/$', view=views.group_edit, name='group_edit'),
    url('^group/(?P<pk>[0-9]+)/delete$', view=views.group_delete, name='group_delete'),
]
