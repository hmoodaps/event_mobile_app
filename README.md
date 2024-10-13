class Movie(models.Model):
name = models.CharField(max_length=100)  # نص
show_times = models.JSONField(default=list)  # مصفوفة لتخزين توقيتات العروض
seats = models.IntegerField(default=100)  # عدد صحيح
available_seats = models.IntegerField(default=seats)
reservations = models.IntegerField(default=0, blank=True)  # عدد صحيح
photo = models.CharField(max_length=255, default="https://st2.depositphotos.com/1105977/9877/i/450/depositphotos_98775856-stock-photo-retro-film-production-accessories-still.jpg")  # نص
vertical_photo = models.CharField(max_length=255, blank=True)  # نص
ticket_price = models.DecimalField(max_digits=5, decimal_places=2)  # عدد عشري
reservedSeats = models.JSONField(default=list, blank=True)  # مصفوفة
description = models.TextField(blank=True)  # نص
short_description = models.TextField(max_length=150,blank=True)  # نص قصير
sponsor_video = models.URLField(blank=True)  # نص
actors = models.JSONField(default=list, blank=True)  # مصفوفة
release_date = models.DateField(blank=True, null=True)  # نص
duration = models.CharField(max_length=50, blank=True)  # نص
rating = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)  # عدد عشري
imdb_rating = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)  # عدد عشري
tags = models.JSONField(default=list, blank=True)  # مصفوفة
fhd_image = models.CharField(max_length=255, blank=True)  # نص لصورة بدقة FHD
genre = models.CharField(max_length=50, blank=True)  # نوع الفيلم

    def __str__(self):
        return self.name

class Guest(models.Model):
full_name = models.CharField(max_length=100)  # نص
age = models.IntegerField()  # عدد صحيح
seats = models.JSONField(default=list)  # مصفوفة
reservations = models.IntegerField(default=0)
movie = models.ForeignKey('Movie', on_delete=models.SET_NULL, null=True, blank=True)  # ربط الضيف بالفيلم