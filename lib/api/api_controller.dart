import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nerdmine/logging/simple_log.dart';
import 'package:nerdmine/model/InstitutueResponse.dart';
import 'package:nerdmine/model/PostCounsellingResposne.dart';
import 'package:nerdmine/model/connect_count_response.dart';
import 'package:nerdmine/model/notification_response.dart';
import 'package:nerdmine/model/post_created_response.dart';
import 'package:nerdmine/model/post_job_picklist_response.dart';
import 'package:nerdmine/model/post_line_item_bottom_sheet_response.dart';
import 'package:nerdmine/model/search_response.dart';
import 'package:nerdmine/model/upload_img_response.dart';
import 'package:nerdmine/model/user_connection_info_response.dart';
import 'package:nerdmine/model/user_info_response.dart';
import 'package:nerdmine/screen/experience_screen.dart';
import 'package:nerdmine/screen/skill_detail_screen.dart';

import '../model/user_info2.dart';
import 'dio_http.dart';

class ApiController {
  static ApiController _instance = ApiController.internal();

  ApiController.internal();

  factory ApiController() {
    return _instance;
  }

  static ApiController getInstance() {
    if (_instance == null) _instance = ApiController.internal();
    return _instance;
  }

  Future<T> post<T>(String url,
      {Map<String, dynamic>? headers, body, encoding, payload}) async {
    // Map<String, dynamic> headersMap = {"Authorization": await AuthUser.getInstance().token()};
    // if (headers != null) headersMap.addAll(headers);

    SimpleLogger.debug(ApiController,
        "Type: Request\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n");

    Response response = await dio.post(
      url,
      data: body,
      queryParameters: payload,
      options: Options(
        contentType: ContentType.json.toString(),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        method: "POST",
        // headers: headersMap,
      ),
    );

    SimpleLogger.debug(ApiController,
        "Type: Response\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n Header: km\n Response:${response.toString()}\n");

    // Decode the JSON response string
    dynamic decodedJson = json.decode(json.encode(response.data));
    // Convert the decoded JSON object to a formatted JSON string
    String formattedJson = JsonEncoder.withIndent('    ').convert(decodedJson);
    print(formattedJson);

    return JsonConverter.fromJson<T>(response.data);
  }

  Future<T> get<T>(String url, {Map? headers, body, encoding, payload}) async {
    // Map<String, String> headerMap = headers ?? {};
    // headerMap["NoEncryption"] = 'true';
    SimpleLogger.debug(ApiController,
        "Type: Request\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n");

    Response response = await dio.get(url,
        queryParameters: payload,
        options: Options(
          contentType: ContentType.json.toString(),
          receiveTimeout: Duration(seconds: 30),
          sendTimeout: Duration(seconds: 30),
          method: "GET",
          // headers: headerMap,
        ));

    SimpleLogger.debug(ApiController,
        "Type: Response\n Api Call: $url\n Inputs: $body\n Payload: ${payload.toString()}\n Header: \n Response:${response.toString()}\n");

    return JsonConverter.fromJson<T>(response.data);
  }
}

class JsonConverter {
  static T fromJson<T>(dynamic value) {
    if (T == PostLineItemBottomSheetResponse)
      return PostLineItemBottomSheetResponse.fromJson(value) as T;
    if (T == PostCreatedResponse)
      return PostCreatedResponse.fromJson(value) as T;
    if (T == ConnectCountResponse)
      return ConnectCountResponse.fromJson(value) as T;
    if (T == UserConnectionInfoResponse)
      return UserConnectionInfoResponse.fromJson(value) as T;
    if (T == UserInfoResponse) return UserInfoResponse.fromJson(value) as T;
    if (T == InstitutueResponse) return InstitutueResponse.fromJson(value) as T;
    if (T == UserInfo2) return UserInfo2.fromJson(value) as T;
    if (T == AddExperienceReponse)
      return AddExperienceReponse.fromJson(value) as T;
    if (T == SkillListResponse) return SkillListResponse.fromJson(value) as T;
    if (T == NotificationResponse)
      return NotificationResponse.fromJson(value) as T;
    if (T == UploadImgResponse) return UploadImgResponse.fromJson(value) as T;
    if (T == PostJobPicklistResponse)
      return PostJobPicklistResponse.fromJson(value) as T;
    if (T == SearchResponse) return SearchResponse.fromJson(value) as T;
    if (T == PostCounsellingResposne)
      return PostCounsellingResposne.fromJson(value) as T;

    return throw Exception("Unknown class");
  }
}
