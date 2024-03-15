import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:urban_match/src/models/commit_model.dart';
import 'package:urban_match/src/models/repository_model.dart';

class ApiService {
  final Dio _dio = Dio()
    ..options = BaseOptions(baseUrl: "https://api.github.com/")
    ..interceptors.add(kDebugMode ? PrettyDioLogger() : const Interceptor());

  /// To fetch the repos for a given user name
  Future<List<GitHubRepo>> getUserRepos(String username) async {
    try {
      final response = await _dio.get('users/$username/repos');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        return responseData.map((json) => GitHubRepo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch user repositories');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const SocketException("No Internet connection");
      } else {
        throw Exception('Failed to fetch user repositories: ${e.error}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user repositories: $e');
    }
  }

  /// will fetch the commits of user's repo
  Future<List<GitHubCommit>> getRepoCommits(String username, String repoName) async {
    try {
      final response = await _dio.get('repos/$username/$repoName/commits');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        return responseData.map((json) => GitHubCommit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch repository commits');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const SocketException("No Internet connection");
      } else {
        throw Exception('Failed to fetch user repositories: ${e.error}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user repositories: $e');
    }
  }

  /// To fetch the pull request count for a particular github repo
  Future<int> getRepoPR(String username, String repoName) async {
    try {
      final response = await _dio.get('repos/$username/$repoName/pulls');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        return responseData.length;
      } else {
        throw Exception('Failed to fetch repository commits');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const SocketException("No Internet connection");
      } else {
        throw Exception('Failed to fetch pull request: ${e.error}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user repositories: $e');
    }
  }
}
