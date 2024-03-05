class PageModel {
  String? cmsId;
  String? pageTitle;
  String? pageSubTitle;
  String? pageContent;
  String? status;

  PageModel(
      {this.cmsId,
        this.pageTitle,
        this.pageSubTitle,
        this.pageContent,
        this.status});

  PageModel.fromJson(Map<String, dynamic> json) {
    cmsId = json['cms_id'];
    pageTitle = json['page_title'];
    pageSubTitle = json['page_sub_title'];
    pageContent = json['page_content'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cms_id'] = this.cmsId;
    data['page_title'] = this.pageTitle;
    data['page_sub_title'] = this.pageSubTitle;
    data['page_content'] = this.pageContent;
    data['status'] = this.status;
    return data;
  }
}
