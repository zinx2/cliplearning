#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#include <QtAndroid>
#include <QDebug>
#include <QDir>
#include "../src/native_app.h"

void NativeApp::full()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("full", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}
QString NativeApp::getDeviceId()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject result = activity.callObjectMethod<jstring>("getDeviceId");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!");
        return "";
    }
    return result.toString();
}

bool NativeApp::needUpdate()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    jboolean jresult = activity.callMethod<jboolean>("needUpdate", "()Z");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!");
        return "";
    }
    return (bool)jresult;
}
QString NativeApp::getPhoneNumber()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject result = activity.callObjectMethod<jstring>("getPhoneNumber");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!");
        return "";
    }
    return result.toString();
}

bool NativeApp::isInstalledApp(QString nameOrScheme)
{
    QAndroidJniObject jsNameOrScheme = QAndroidJniObject::fromString(nameOrScheme);
    QAndroidJniObject activity = QtAndroid::androidActivity();
    jboolean jresult = activity.callMethod<jboolean>("isInstalledApp", "(Ljava/lang/String;)Z", jsNameOrScheme.object<jstring>());

    QAndroidJniEnvironment env;
    if(env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!!");
        return false;
    }
    return (bool)jresult;
}

int NativeApp::isOnline()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    jint jresult = activity.callMethod<jint>("isOnline", "()I");

    QAndroidJniEnvironment env;
    if(env->ExceptionCheck())
    {
        env->ExceptionDescribe();
        env->ExceptionClear();
        qCritical("Something Was Wrong!!!");
        return false;
    }
    return (int)jresult;
}

void NativeApp::joinKakao()
{

}

void NativeApp::loginKakao()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("loginKakao", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::logoutKakao()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("logoutKakao", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::withdrawKakao()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("withdrawKakao", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::inviteKakao(QString senderId, QString image, QString title, QString desc, QString link)
{
    QAndroidJniObject idStr = QAndroidJniObject::fromString(senderId);
    QAndroidJniObject imageStr = QAndroidJniObject::fromString(image);
    QAndroidJniObject titleStr = QAndroidJniObject::fromString(title);
    QAndroidJniObject descStr = QAndroidJniObject::fromString(desc);
    QAndroidJniObject linkStr = QAndroidJniObject::fromString(link);

    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("inviteKakao", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                              idStr.object<jstring>(), imageStr.object<jstring>(), titleStr.object<jstring>(), descStr.object<jstring>(), linkStr.object<jstring>());

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::loginFacebook()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("loginFacebook", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::logoutFacebook()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("logoutFacebook", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::withdrawFacebook()
{
    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("withdrawFacebook", "()V");

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::inviteFacebook(QString senderId, QString image, QString title, QString desc, QString link)
{
    QAndroidJniObject idStr = QAndroidJniObject::fromString(senderId);
    QAndroidJniObject imageStr = QAndroidJniObject::fromString(image);
    QAndroidJniObject titleStr = QAndroidJniObject::fromString(title);
    QAndroidJniObject descStr = QAndroidJniObject::fromString(desc);
    QAndroidJniObject linkStr = QAndroidJniObject::fromString(link);

    QAndroidJniObject activity = QtAndroid::androidActivity();
    activity.callMethod<void>("inviteFacebook", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                              idStr.object<jstring>(), imageStr.object<jstring>(), titleStr.object<jstring>(), descStr.object<jstring>(), linkStr.object<jstring>());

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck())
    {
      env->ExceptionDescribe();
      env->ExceptionClear();
    }
}

void NativeApp::setStatusBarColor(QString colorString)
{
  QAndroidJniObject activity = QtAndroid::androidActivity();
  activity.callMethod<void>("setStatusBarColor", "(Ljava/lang/String;)V",
                            QAndroidJniObject::fromString(colorString).object<jstring>());

  QAndroidJniEnvironment env;
  if (env->ExceptionCheck())
  {
    env->ExceptionDescribe();
    env->ExceptionClear();
  }
}
