package io.agora.rte.extension.hteffectar.example;

import android.Manifest;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.RelativeLayout;
import androidx.annotation.NonNull;
import androidx.databinding.Observable;
import androidx.databinding.ObservableBoolean;
import com.texeljoy.hteffectar.UnityPlayerActivity;
import io.agora.rtc2.Constants;
import io.agora.rtc2.IMediaExtensionObserver;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.RtcEngine;
import io.agora.rtc2.RtcEngineConfig;
import io.agora.rtc2.video.VideoCanvas;
import java.util.Arrays;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity
    extends UnityPlayerActivity implements IMediaExtensionObserver {

    private static final String TAG = "DEBUG";

    private RtcEngine mRtcEngine;

    private Button button;
    private Button buttonModels;
    private Button buttonSwitch;
    private boolean isMirror = true;
    private int count = 0;
    private String[] modelNameList =  { "ht_3d_effect_cap", "ht_3d_effect_tiger", "ht_3d_effect_indian", "ht_3d_effect_giraffe", "ht_3d_effect_glasses", "ht_3d_effect_huahuan"};


    private RelativeLayout unityView;
    private final ObservableBoolean enableExtension =
        new ObservableBoolean(false);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

       initUI();
       initData();
       initPermission();
    }

    private void initData() {
        enableExtension.addOnPropertyChangedCallback(
            new Observable.OnPropertyChangedCallback() {
                @Override
                public void onPropertyChanged(Observable sender, int propertyId) {
                    if (sender instanceof ObservableBoolean) {
                        boolean enabled = ((ObservableBoolean) sender).get();
                        Log.i("DEBUG: ", "enableExtension");
                        enableExtension(enabled);

                        if (enabled) {
                            button.setText(R.string.disable_extension);
                            buttonModels.setEnabled(true);
                            enableRender(true);
                            mUnityPlayer.resume();

                        } else {
                            button.setText(R.string.enable_extension);
                            buttonModels.setEnabled(false);
                            enableRender(false);
                            mUnityPlayer.pause();
                        }
                    }
                }
            });
    }

    private void initUI() {
        unityView = findViewById(R.id.unityView);
        unityView.addView(mUnityPlayer);

        button = findViewById(R.id.button_enable);
        button.setOnClickListener(
            view -> enableExtension.set(!enableExtension.get()));
        buttonModels = findViewById(R.id.button_setmodels);
        buttonModels.setOnClickListener(view -> choiceModel());

        buttonSwitch = findViewById(R.id.button_switch);
        buttonSwitch.setVisibility(View.GONE);
        buttonSwitch.setOnClickListener(new OnClickListener() {
            @Override public void onClick(View v) {
                mRtcEngine.switchCamera();
                isMirror = !isMirror;
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("isMirror", isMirror);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                setExtensionProperty("htARMirror", jsonObject.toString());
            }
        });


    }

    private void initExtension() {
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("license", HtKey.HTKey);
            setExtensionProperty("htARInitOffline", jsonObject.toString());

        } catch (JSONException e) {
            Log.e(TAG, e.toString());
        }
    }
    private void enableExtension(boolean enabled) {
        mRtcEngine.enableExtension("Texeljoy", "HTAvatar", enabled);
    }

    private void setExtensionProperty(String key, String property) {
        mRtcEngine.setExtensionProperty("Texeljoy", "HTAvatar", key, property);
    }


    private void choiceModel() {
        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name",modelNameList[count]);
            setExtensionProperty("htARSetModel", jsonObject.toString());
            // buttonModels.setEnabled(false);

        } catch (JSONException e) {
            Log.e(TAG, e.toString());
        }
        if(count < 5){
            count ++;
        }else{
            count = 0;
        }

    }

    private void enableRender(boolean enable) {
        try {

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("enable",enable);
            setExtensionProperty("htARRenderEnable", jsonObject.toString());

        } catch (JSONException e) {
            Log.e(TAG, e.toString());
        }
    }


    private void initPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(new String[] { Manifest.permission.CAMERA,
                    Manifest.permission.RECORD_AUDIO },
                0);
        } else {
            Log.i("DEBUG: ", "initRtcEngine");
            initRtcEngine();
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 0) {
            if (Arrays.equals(grantResults, new int[] { 0, 0 })) {
                initRtcEngine();
            }
        }
    }


    private void initRtcEngine() {
        RtcEngineConfig config = new RtcEngineConfig();
        config.mContext = getApplicationContext();
        config.mAppId = io.agora.rte.extension.hteffectar.example.Constants.mAppId;
        config.mExtensionObserver = this;
        config.addExtension("AgoraHTAvatarExtension");
        config.mEventHandler = new IRtcEngineEventHandler() {
            @Override
            public void onWarning(int warn) {
                Log.w(TAG, String.format("onWarning %d", warn));
            }

            @Override
            public void onError(int err) {
                Log.e(TAG, String.format("onError %d", err));
            }

            @Override
            public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
                Log.i(TAG, String.format("onJoinChannelSuccess %s %d %d", channel, uid, elapsed));
            }
            @Override
            public void onLocalVideoStateChanged(Constants.VideoSourceType source, int state, int error) {
                super.onLocalVideoStateChanged(source, state, error);
                Log.i(TAG, String.format("onLocalVideoStateChanged %s %d %d", source.toString(), state, error));
            }
        };
        try {
            mRtcEngine = RtcEngine.create(config);
        } catch (Exception e) {
            Log.e(TAG, e.toString());
        }
        if (mRtcEngine == null) {
            return;
        }
        enableExtension.set(true);
        mRtcEngine.enableVideo();
        mRtcEngine.setChannelProfile(Constants.CHANNEL_PROFILE_LIVE_BROADCASTING);
        mRtcEngine.setClientRole(Constants.CLIENT_ROLE_BROADCASTER);
        mRtcEngine.startPreview();

        runOnUiThread(() -> {
            initExtension();
            VideoCanvas canvas = new VideoCanvas(findViewById(R.id.surfaceView));
            mRtcEngine.setupLocalVideo(canvas);
        });
    }


    @Override public void onEvent(String provider, String extension, String key, String value) {
        Log.d(TAG, "onEvent provider: " + provider + "  extension: " + extension + "  key: " + key + "  value: " + value);
    }

    @Override public void onStarted(String provider, String extension) {

    }

    @Override public void onStopped(String provider, String extension) {

    }

    @Override public void onError(String provider, String extension, int errCode, String errMsg) {

    }
}