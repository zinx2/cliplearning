/*
  Copyright 2014-2017 Kakao Corp.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
 */
package com.kakao.kakaotalk.request;

import android.net.Uri;

import com.kakao.auth.network.request.ApiRequest;
import com.kakao.kakaotalk.StringSet;
import com.kakao.network.ServerProtocol;

/**
 * @author leoshin, created at 15. 7. 27..
 */
public class TalkProfileRequest extends ApiRequest {

    private final boolean secureResource;
    public TalkProfileRequest() {
        this.secureResource = false;
    }

    public TalkProfileRequest(boolean secureResource) {
        this.secureResource = secureResource;
    }

    @Override
    public String getMethod() {
        return GET;
    }

    @Override
    public Uri.Builder getUriBuilder() {
        return super.getUriBuilder().path(ServerProtocol.TALK_PROFILE_PATH)
                .appendQueryParameter(StringSet.secure_resource, String.valueOf(secureResource));
    }
}
