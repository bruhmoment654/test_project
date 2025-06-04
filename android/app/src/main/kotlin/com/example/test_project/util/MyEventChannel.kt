package com.example.test_project.util

import android.app.Activity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

enum class CounterKeys { STOP_COUNTER, START_COUNTER }


object MyEventChannel {

    private const val EVENT_CHANNEL_NAME = "EVENT_CHANNEL_NAME"
    private const val METHOD_CHANNEL_NAME = "METHOD_CHANNEL_NAME"

    private var eventSink: EventChannel.EventSink? = null

    private var isCounting = false

    suspend fun setup(flutterEngine: FlutterEngine) {

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        val channel = MethodChannel(messenger, METHOD_CHANNEL_NAME)

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                CounterKeys.START_COUNTER.name -> {
                    startCounter()
                    result.success(null)
                }

                CounterKeys.STOP_COUNTER.name -> {
                    stopCounter()
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }

        val eventChannel = EventChannel(messenger, EVENT_CHANNEL_NAME)
        eventChannel.setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events

                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }

            }
        )

        runFlow()
    }

    private fun startCounter() {
        isCounting = true
    }

    private fun stopCounter() {
        isCounting = false
    }

    private suspend fun runFlow() {
        var i = 0
        val testFlow: Flow<Int> = flow {
            while (true) {
                if (isCounting) {
                    emit(i)
                    println("EVENT_CHANNEL_EVENT $i")
                    i++
                }
                delay(1000)
            }
        }

        testFlow.collect { result ->
            eventSink?.success(result)
        }
    }
}