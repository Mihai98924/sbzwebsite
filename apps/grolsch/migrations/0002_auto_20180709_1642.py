# -*- coding: utf-8 -*-
# Generated by Django 1.11.14 on 2018-07-09 14:42
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('grolsch', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='last_discount_price',
            field=models.PositiveIntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='product',
            name='last_price',
            field=models.PositiveIntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='product',
            name='price_track_id',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]