import 'package:flutter/material.dart';
import 'package:sosty/domain/models/project/project_progress_event.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/helpers/download_file_helper.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class InvestmentsTimelineItem extends StatefulWidget {
  const InvestmentsTimelineItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  final ProjectProgressEvent event;

  @override
  _InvestmentsTimelineItemState createState() =>
      _InvestmentsTimelineItemState();
}

class _InvestmentsTimelineItemState extends State<InvestmentsTimelineItem> {
  late DownloadFileHelper _downloadFileHelper;
  final int _listViewCrossAxisCount = 4;
  final List<String> _images = [];
  final List<String> _files = [];

  void _getImages() {
    if (widget.event.picture1Url != null) {
      _images.add(widget.event.picture1Url!);
    } else if (widget.event.picture2Url != null) {
      _images.add(widget.event.picture2Url!);
    } else if (widget.event.picture3Url != null) {
      _images.add(widget.event.picture3Url!);
    } else if (widget.event.picture4Url != null) {
      _images.add(widget.event.picture4Url!);
    } else if (widget.event.picture5Url != null) {
      _images.add(widget.event.picture5Url!);
    }
  }

  void _getFiles() {
    if (widget.event.file1Url != null) {
      _files.add(widget.event.file1Url!);
    } else if (widget.event.file2Url != null) {
      _files.add(widget.event.file2Url!);
    } else if (widget.event.file3Url != null) {
      _files.add(widget.event.file3Url!);
    }
  }

  bool _isInteger(num value) => (value % 1) == 0;

  int _getListViewRows() {
    final int eventFiles = _images.length + _files.length;
    final double totalRows = eventFiles / _listViewCrossAxisCount;
    return _isInteger(totalRows) ? totalRows.toInt() : (totalRows.toInt() + 1);
  }

  @override
  void initState() {
    super.initState();
    _getImages();
    _getFiles();
    _downloadFileHelper = DownloadFileHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.eventType,
            style: Styles.bodyText1Bold,
          ),
          Text(
            FormatterHelper.shortDate(widget.event.eventDate),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.event.description,
            style: Styles.bodyText2,
          ),
          if (_images.isNotEmpty || _files.isNotEmpty)
            SizedBox(
              height: 75.0 * _getListViewRows(),
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: _listViewCrossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ...List.generate(
                    _images.length,
                    (index) => GestureDetector(
                      onTap: () => _downloadFileHelper.downloadFile(
                        context: context,
                        url: _images[index],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          _images[index],
                        ),
                      ),
                    ),
                  ),
                  ...List.generate(
                    _files.length,
                    (index) => IconButton(
                      onPressed: () => _downloadFileHelper.downloadFile(
                        context: context,
                        url: _files[index],
                      ),
                      icon: const Icon(
                        Icons.file_present,
                      ),
                      iconSize: 24,
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
