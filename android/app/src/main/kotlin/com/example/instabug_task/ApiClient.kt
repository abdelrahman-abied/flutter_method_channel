import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.Request

class MovieApiPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "movie_api")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "fetchMovies" -> {
                GlobalScope.launch {
                    val movies = fetchMovies()
                    withContext(Dispatchers.Main) {
                        result.success(movies)
                    }
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }
    private suspend  fun fetchMovies(): String {
    val client = OkHttpClient()
    val request = Request.Builder()
        .url("https://api.themoviedb.org/3/movie/popular?api_key=API_KEY")
        .build()
    val response = withContext(Dispatchers.IO) {
        client.newCall(request).execute()
    }
    val json = response.body?.string() ?: ""

        return json
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}