package com.example.home_screen

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetBackgroundService
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                    MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val path = widgetData.getString("path", "")
                setImageViewUri(R.id.imageView, Uri.parse(path))

                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                    Uri.parse("myAppWidget://updateimage"))
                setOnClickPendingIntent(R.id.button, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}