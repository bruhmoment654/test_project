package com.example.test_project.work_manager

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.work.Worker
import androidx.work.WorkerParameters

class MyWorker(context: Context, workerParams: WorkerParameters) : Worker(context, workerParams) {


    override fun doWork(): Result {
        try {
            val notification = NotificationCompat.Builder(applicationContext, "default")
                .setContentTitle("lmao")
                .setContentText("lmao task")
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                .build()

            if (ActivityCompat.checkSelfPermission(
                    applicationContext,
                    Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return Result.failure()
            }
            NotificationManagerCompat.from(applicationContext).notify(1, notification)

        } catch (e: Exception) {
            return Result.failure()
        }

        return Result.success()
    }


}