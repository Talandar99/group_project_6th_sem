class MessageDto {
  String message;

  MessageDto({required this.message});

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(message: json['message']);
  }
}
