import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeFive({
  bool? hasSaved,
  String? firstName,
  String? lastName,
  String? designation,
  String? address,
  String? emailAddress,
  String? phoneNo,
  List? skill,
  List? education,
  List? experience,
  List? project,
  List? certificate,
  String? profile,
  String? countryCode,
}) async {
  final resume5 = Document();

  final nameFont = await PdfGoogleFonts.poppinsRegular();
  // final jobTitleFont = await PdfGoogleFonts.montserratMedium();

  final emailIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/emailWhite.png'))
          .buffer
          .asUint8List());
  final phoneCallIconWhiteInverted = MemoryImage(
      (await rootBundle.load('assets/icons/phoneCallWhiteInverted.png'))
          .buffer
          .asUint8List());
  final pinIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/pinWhite.png'))
          .buffer
          .asUint8List());

  resume5.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      ),
      build: (context) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 200,
                  height: double.infinity,
                  decoration: BoxDecoration(color: PdfColor.fromHex("#272324")),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 28),
                          Container(
                              alignment: Alignment.centerRight,
                              // color: PdfColors.amberAccent700,
                              width: 172,
                              child: Text(firstName.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.normal,
                                      font: nameFont))),
                          Container(
                              alignment: Alignment.centerRight,
                              width: 172,
                              // color: PdfColors.amberAccent700,
                              child: Text(lastName.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.normal,
                                      font: nameFont))),
                          SizedBox(height: 8),
                          Container(
                              alignment: Alignment.centerRight,
                              width: 172,
                              // color: PdfColors.amberAccent700,
                              child: Text(designation.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal))),
                          SizedBox(height: 28),
                          Container(
                              height: 1,
                              width: 160,
                              decoration:
                                  const BoxDecoration(color: PdfColors.white)),
                          SizedBox(height: 22),
                          Text("CONTACT",
                              style: TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontSize: 14)),
                          SizedBox(height: 22),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 132,
                                  alignment: Alignment.centerRight,
                                  // color: PdfColors.amberAccent700,
                                  child: Text(
                                      "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: PdfColors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                ),
                                SizedBox(width: 12),
                                Image(phoneCallIconWhiteInverted,
                                    height: 14, width: 14)
                              ]),
                          SizedBox(height: 12),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 132,
                                  alignment: Alignment.centerRight,
                                  // color: PdfColors.amberAccent700,
                                  child: Text(emailAddress.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: PdfColors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                ),
                                SizedBox(width: 12),
                                Image(emailIconWhite, height: 14, width: 14)
                              ]),
                          SizedBox(height: 12),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 132,
                                  alignment: Alignment.centerRight,
                                  // color: PdfColors.amberAccent700,
                                  child: Text(address.toString(),
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: PdfColors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                ),
                                SizedBox(width: 12),
                                Image(pinIconWhite, height: 14, width: 14)
                              ]),
                          education!.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 22),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : Container(
                                  height: 1,
                                  width: 160,
                                  decoration: const BoxDecoration(
                                      color: PdfColors.white)),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 22),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : Text("EDUCATION",
                                  style: TextStyle(
                                      color: PdfColors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontSize: 14)),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 22),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: education.length,
                                  itemBuilder: (context, int index) {
                                    final educations = education[index];
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 162,
                                                alignment:
                                                    Alignment.centerRight,
                                                // color: PdfColors.red100,
                                                child: Text(
                                                    educations.degree
                                                        .toString()
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.right,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color: PdfColors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                width: 162,
                                                alignment:
                                                    Alignment.centerRight,
                                                // color: PdfColors.red100,
                                                child: Text(
                                                    educations.schoolOrCollege
                                                        .toString(),
                                                    textAlign: TextAlign.right,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFFDEDEDE),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                // color: PdfColors.red100,
                                                width: 162,
                                                child: Text(
                                                    "${educations.start} - ${educations.end}",
                                                    textAlign: TextAlign.right,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFFDEDEDE),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              )
                                            ]));
                                  },
                                ),
                          skill!.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 12),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : Container(
                                  height: 1,
                                  width: 160,
                                  decoration: const BoxDecoration(
                                      color: PdfColors.white)),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 22),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : Text("SKILLS",
                                  style: TextStyle(
                                      color: PdfColors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontSize: 14)),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 22),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  itemCount: skill.length,
                                  itemBuilder: (context, int index) {
                                    final skills = skill[index];
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: Container(
                                            width: 140,
                                            alignment: Alignment.centerRight,
                                            // color: PdfColors.red100,
                                            child: RichText(
                                                textAlign: TextAlign.right,
                                                maxLines: 2,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: skills.skillName
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: PdfColors.white,
                                                      )),
                                                  TextSpan(
                                                      text: "  -",
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFFDEDEDE),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]))));
                                  },
                                ),
                        ]),
                  )),
              SizedBox(width: 24),
              Container(
                  height: double.infinity,
                  width: 372,
                  // color: PdfColors.amberAccent700,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 36),
                        Text("PROFILE",
                            style: TextStyle(
                                color: PdfColors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontSize: 14)),
                        SizedBox(height: 22),
                        Container(
                            width: 334,
                            // color: PdfColors.amber,
                            alignment: Alignment.centerLeft,
                            child: Text(profile.toString(),
                                maxLines: 5,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: const PdfColor.fromInt(0xFF444343),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                        SizedBox(height: 22),
                        Container(
                            height: 1,
                            width: 334,
                            decoration:
                                const BoxDecoration(color: PdfColors.black)),
                        experience!.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 22),
                        experience.isEmpty
                            ? SizedBox(height: 0)
                            : Text("WORK EXPERIENCE",
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    fontSize: 14)),
                        experience.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 22),
                        experience.isEmpty
                            ? SizedBox(height: 0)
                            : ListView.builder(
                                reverse: true,
                                itemCount: experience
                                    .length, // the number of items in the list
                                itemBuilder: (context, int index) {
                                  final experiences = experience[
                                      index]; // get the skill at the current index
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 116,
                                                      // color: PdfColors
                                                      //     .amberAccent700,
                                                      child: Text(
                                                          experiences.jobTitle
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color: PdfColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12))),
                                                  SizedBox(height: 4),
                                                  Container(
                                                      width: 116,
                                                      child: Text(
                                                          "${experiences.start.toString()} - ${experiences.end.toString()}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                            fontSize: 11,
                                                          )))
                                                ]),
                                            SizedBox(width: 18),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 200,
                                                      // color: PdfColors
                                                      //     .amberAccent700,
                                                      child: Text(
                                                          "${experiences.employer}, ${capitalizeFirstLetterOfEachWord(experiences.city.toString())}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                            fontSize: 11,
                                                          ))),
                                                  SizedBox(height: 4),
                                                  Container(
                                                      width: 200,
                                                      // color: PdfColors
                                                      //     .amberAccent700,
                                                      child: Text(
                                                          experiences
                                                              .description,
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                            fontSize: 11,
                                                          ))),
                                                ])
                                          ]));
                                },
                              ),
                        project!.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 22),
                        project.isEmpty
                            ? SizedBox(height: 0)
                            : Text("EXPERIENCE",
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    fontSize: 14)),
                        project.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 22),
                        project.isEmpty
                            ? SizedBox(height: 0)
                            : ListView.builder(
                                reverse: true,
                                itemCount: project
                                    .length, // the number of items in the list
                                itemBuilder: (context, int index) {
                                  final projects = project[
                                      index]; // get the skill at the current index
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 116,
                                                      // color: PdfColors
                                                      //     .amberAccent700,
                                                      child: Text(
                                                          projects.projectName
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color: PdfColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12))),
                                                  SizedBox(height: 4),
                                                  Container(
                                                      width: 116,
                                                      child: Text(
                                                          projects.projectDate
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                            fontSize: 11,
                                                          )))
                                                ]),
                                            SizedBox(width: 18),
                                            Container(
                                                width: 200,
                                                // color: PdfColors
                                                //     .amberAccent700,
                                                child: Text(
                                                    projects.projectDescription,
                                                    maxLines: 3,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: const PdfColor
                                                          .fromInt(0xFF444343),
                                                      fontSize: 11,
                                                    )))
                                          ]));
                                },
                              ),
                        certificate!.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 22),
                        certificate.isEmpty
                            ? SizedBox(height: 0)
                            : Text("CERTIFICATES",
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    fontSize: 14)),
                        certificate.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 22),
                        certificate.isEmpty
                            ? SizedBox(height: 0)
                            : ListView.builder(
                                reverse: true,
                                itemCount: certificate
                                    .length, // the number of items in the list
                                itemBuilder: (context, int index) {
                                  final certificates = certificate[
                                      index]; // get the skill at the current index
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 116,
                                                      // color: PdfColors
                                                      //     .amberAccent700,
                                                      child: Text(
                                                          certificates
                                                              .issuedFor,
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color: PdfColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12))),
                                                  SizedBox(height: 4),
                                                  Container(
                                                      width: 116,
                                                      child: Text(
                                                          certificates.issuedOn,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                            fontSize: 11,
                                                          )))
                                                ]),
                                            SizedBox(width: 18),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 200,
                                                      // color: PdfColors
                                                      //     .amberAccent700,
                                                      child: Text(
                                                          certificates
                                                              .issuingBody,
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                            fontSize: 11,
                                                          ))),
                                                ])
                                          ]));
                                },
                              ),
                      ]))
            ]);
      },
    ),
  );
  return resume5.save();
}
