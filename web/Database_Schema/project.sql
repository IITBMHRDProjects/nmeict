-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 20, 2016 at 11:29 AM
-- Server version: 5.5.52-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic`
--

CREATE TABLE IF NOT EXISTS `academic` (
  `instituteid` int(11) NOT NULL,
  `streamid` int(11) DEFAULT NULL,
  `head_title` int(11) DEFAULT NULL,
  `headname` varchar(150) DEFAULT NULL,
  `heademail` varchar(100) DEFAULT NULL,
  `head_designation` int(11) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `headaddress` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isActive` int(11) DEFAULT '0',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `head_contact` varchar(20) DEFAULT NULL,
  `last_updatedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_academy_id` (`instituteid`),
  KEY `head_designation_id` (`head_designation`),
  KEY `head_title_id` (`head_title`),
  KEY `idstream` (`streamid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33904 ;

-- --------------------------------------------------------

--
-- Table structure for table `accomodation`
--

CREATE TABLE IF NOT EXISTS `accomodation` (
  `participantid` int(20) NOT NULL,
  `workshopid` int(20) DEFAULT NULL,
  `instituteid` int(20) DEFAULT NULL,
  `accomodation` varchar(20) DEFAULT NULL,
  `acc_old` varchar(20) DEFAULT NULL,
  `ins_same_as_rc` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`participantid`),
  KEY `participant_id` (`participantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE IF NOT EXISTS `announcement` (
  `announcementid` int(11) NOT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `announcement` varchar(450) DEFAULT NULL,
  `link` varchar(250) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `status` varchar(40) NOT NULL,
  `location` varchar(100) NOT NULL,
  `visible` varchar(1) DEFAULT 'Y',
  PRIMARY KEY (`announcementid`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `announcementtype`
--

CREATE TABLE IF NOT EXISTS `announcementtype` (
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE IF NOT EXISTS `attendance` (
  `workshopid` int(11) NOT NULL,
  `participantid` int(11) NOT NULL,
  `rcid` int(11) NOT NULL,
  `session` int(11) NOT NULL,
  `isPresent` varchar(10) DEFAULT 'No',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `participantid` (`participantid`),
  KEY `session` (`session`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=277223 ;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_audit`
--

CREATE TABLE IF NOT EXISTS `certificate_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) NOT NULL,
  `rcid` int(11) NOT NULL,
  `dispatch` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `updated_by` (`updated_by`),
  KEY `rcid` (`rcid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=770 ;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `stateid` int(11) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `isActive` int(11) DEFAULT NULL,
  PRIMARY KEY (`cityid`),
  KEY `stateid` (`stateid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3269 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `confirmed_participants`
--
CREATE TABLE IF NOT EXISTS `confirmed_participants` (
`workshopid` int(20)
,`rcid` int(20)
,`accomodation` varchar(20)
,`participantid` int(11)
,`experience` varchar(45)
,`qualification` varchar(50)
,`instituteid` varchar(11)
,`streamid` varchar(11)
,`Female` int(1)
,`Male` int(1)
,`otherg` int(1)
,`unknown_exp` int(1)
,`less_than_2` int(1)
,`2_to_10` int(1)
,`greater_than_10` int(1)
,`Doctorate` int(1)
,`PostGraduate` int(1)
,`Graduate` int(1)
,`Diploma` int(1)
,`others` int(3)
,`email` varchar(80)
,`city` varchar(11)
,`state` varchar(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `contactus`
--

CREATE TABLE IF NOT EXISTS `contactus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(40) NOT NULL,
  `contact_email` varchar(50) NOT NULL,
  `message` varchar(200) NOT NULL,
  `submitted_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=944 ;

-- --------------------------------------------------------

--
-- Table structure for table `context`
--

CREATE TABLE IF NOT EXISTS `context` (
  `idcontext` int(11) NOT NULL,
  `email` varchar(80) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `homephone` varchar(15) DEFAULT NULL,
  `login_name` varchar(20) DEFAULT NULL,
  `email_verified` int(11) DEFAULT NULL,
  `mobile_verified` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idcontext`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `coordinatorregistration`
--

CREATE TABLE IF NOT EXISTS `coordinatorregistration` (
  `coordinatorid` int(11) NOT NULL,
  `participanttitle` int(11) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `genderinfo` char(1) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `designation` int(11) DEFAULT NULL,
  `discipline` varchar(45) DEFAULT NULL,
  `qualification` varchar(45) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `rcid` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `regtime` timestamp NULL DEFAULT NULL,
  `workshopid` int(11) DEFAULT NULL,
  PRIMARY KEY (`coordinatorid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Stand-in structure for view `designation`
--
CREATE TABLE IF NOT EXISTS `designation` (
`iddesignation` varchar(15)
,`designation` varchar(240)
,`isActive` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `downloads`
--

CREATE TABLE IF NOT EXISTS `downloads` (
  `workshopid` int(11) NOT NULL,
  `session` varchar(30) NOT NULL,
  `video_name` varchar(150) NOT NULL,
  `file_name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE IF NOT EXISTS `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30362 ;

-- --------------------------------------------------------

--
-- Table structure for table `generatepdfcode`
--

CREATE TABLE IF NOT EXISTS `generatepdfcode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) DEFAULT NULL,
  `rcid` int(11) DEFAULT NULL,
  `generatecode` text,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `generated_by` int(11) DEFAULT NULL,
  `generated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3744 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `headdesignation`
--
CREATE TABLE IF NOT EXISTS `headdesignation` (
`headdesignation_id` varchar(15)
,`head_designation` varchar(240)
,`isActive` int(11)
);
-- --------------------------------------------------------
--
-- Stand-in structure for view `head_title`
--
CREATE TABLE IF NOT EXISTS `head_title` (
`head_title_id` varchar(15)
,`head_title` varchar(240)
,`isActive` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `institute`
--

CREATE TABLE IF NOT EXISTS `institute` (
  `idInstitute` int(11) NOT NULL AUTO_INCREMENT,
  `Institutename` varchar(250) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `address` varchar(450) DEFAULT NULL,
  `accredition` int(11) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `officephone` varchar(40) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_updatedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`idInstitute`),
  KEY `state` (`state`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8412 ;

-- --------------------------------------------------------

--
-- Table structure for table `institute_size`
--

CREATE TABLE IF NOT EXISTS `institute_size` (
  `idinstitute_size` int(11) NOT NULL,
  `stream_id` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`idinstitute_size`),
  KEY `instituteid` (`idinstitute_size`),
  KEY `stream_id` (`stream_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `letter`
--

CREATE TABLE IF NOT EXISTS `letter` (
  `participantid` int(11) NOT NULL,
  `workshopid` int(11) DEFAULT NULL,
  `letter` varchar(120) DEFAULT NULL,
  `verified` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`participantid`),
  KEY `participantid` (`participantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(300) DEFAULT NULL,
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `expirydate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `login_id` int(11) NOT NULL,
  `login_name` varchar(75) DEFAULT NULL,
  `password` varchar(75) DEFAULT NULL,
  `usertypeid` varchar(75) DEFAULT NULL,
  `loginstatus` varchar(75) NOT NULL DEFAULT '1',
  `last_login` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `no_of_logins` int(11) DEFAULT '0',
  `ipaddress` varchar(80) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  UNIQUE KEY `login_name` (`login_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(100) NOT NULL,
  `time_of_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `browser_used` varchar(50) NOT NULL,
  `os_used` varchar(50) NOT NULL,
  `time_of_logout` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=150189 ;

-- --------------------------------------------------------

--
-- Table structure for table `lookups`
--

CREATE TABLE IF NOT EXISTS `lookups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `code` varchar(15) DEFAULT NULL,
  `description` varchar(240) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  `isActive` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_combined` (`category`,`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2215 ;

-- --------------------------------------------------------


--
-- Table structure for table `pagelist`
--

CREATE TABLE IF NOT EXISTS `pagelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` varchar(150) DEFAULT NULL,
  `class` varchar(100) DEFAULT NULL,
  `content` text,
  `comment` text,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_updatedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

-- --------------------------------------------------------

--
-- Table structure for table `participant`
--

CREATE TABLE IF NOT EXISTS `participant` (
  `participantid` int(11) NOT NULL,
  `contextid` int(11) DEFAULT NULL,
  `personid` int(11) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `instituteid_streamid` varchar(20) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `regtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `instituteid` int(11) DEFAULT NULL,
  `streamid` int(11) DEFAULT NULL,
  `payment` varchar(20) NOT NULL DEFAULT 'not paid',
  `eligible_for_certificate` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`participantid`),
  KEY `contextid` (`contextid`),
  KEY `personid` (`personid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `participantreasons`
--

CREATE TABLE IF NOT EXISTS `participantreasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) DEFAULT NULL,
  `participantid` int(11) DEFAULT NULL,
  `status` varchar(200) DEFAULT NULL,
  `reasons` text,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `participantid` (`participantid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2252 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `ParticipantTitle`
--
CREATE TABLE IF NOT EXISTS `ParticipantTitle` (
`participant_titlte_id` varchar(15)
,`participanttitle` varchar(240)
,`isActive` int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `participant_status`
--
CREATE TABLE IF NOT EXISTS `participant_status` (
`workshop` int(11)
,`name` text
,`status` varchar(30)
,`count` bigint(21)
,`startdate` date
,`enddate` date
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `participant_status1`
--
CREATE TABLE IF NOT EXISTS `participant_status1` (
`workshop` int(11)
,`name` text
,`status` varchar(30)
,`count` bigint(21)
,`startdate` date
,`enddate` date
);
-- --------------------------------------------------------

--
-- Table structure for table `partuserdata`
--

CREATE TABLE IF NOT EXISTS `partuserdata` (
  `userinterfaceid` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) DEFAULT NULL,
  `rcid` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `discipline` varchar(50) DEFAULT NULL,
  `experience` varchar(50) DEFAULT NULL,
  `Gender` varchar(50) DEFAULT NULL,
  `homeaddress` varchar(450) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  `contactno` varchar(15) DEFAULT NULL,
  `institutename` varchar(250) DEFAULT NULL,
  `titleid` int(11) DEFAULT NULL,
  `qualificationid` int(11) DEFAULT NULL,
  `designationid` int(11) DEFAULT NULL,
  `streamid` int(11) DEFAULT NULL,
  `instituteid` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `participanttype` varchar(30) DEFAULT NULL,
  `errormessage` text,
  `created_by` int(11) DEFAULT NULL,
  `createdon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastupdatedby` int(11) DEFAULT NULL,
  `lastupdateon` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `filename` varchar(100) DEFAULT NULL,
  `filename_id` int(11) DEFAULT NULL,
  `stateid` int(11) DEFAULT NULL,
  PRIMARY KEY (`userinterfaceid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=566 ;

-- --------------------------------------------------------

--
-- Table structure for table `paymentdetails`
--

CREATE TABLE IF NOT EXISTS `paymentdetails` (
  `uid` int(11) NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `reqid` varchar(50) DEFAULT NULL,
  `reqtype` varchar(20) DEFAULT NULL,
  `totalamt` varchar(50) DEFAULT NULL,
  `transid` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_time` varchar(20) DEFAULT NULL,
  `provid` varchar(50) DEFAULT NULL,
  `msg` text,
  `workshopid` int(11) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `purpose` varchar(200) DEFAULT NULL,
  `appid` varchar(100) DEFAULT NULL,
  `recon_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `recon_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `personid` int(11) NOT NULL,
  `title_id` int(11) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `designation` int(11) DEFAULT NULL,
  `genderinfo` char(1) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(180) DEFAULT NULL,
  `pincode` int(10) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `streamid` int(11) DEFAULT NULL,
  `instituteid` int(11) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `aadharid` varchar(12) DEFAULT NULL,
  `yearofbirth` int(4) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `facultystatus` int(5) DEFAULT NULL,
  PRIMARY KEY (`personid`),
  KEY `designationid` (`designation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `program_schedule`
--

CREATE TABLE IF NOT EXISTS `program_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) NOT NULL,
  `date` date NOT NULL,
  `sessionid` int(11) NOT NULL,
  `isActive` int(1) DEFAULT '1',
  `comments` text,
  `time_from` varchar(11) DEFAULT NULL,
  `time_to` varchar(11) DEFAULT NULL,
  `update_till` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=151 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `qualification`
--
CREATE TABLE IF NOT EXISTS `qualification` (
`qualification_id` varchar(15)
,`qualification` varchar(240)
,`active` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `remotecenter`
--

CREATE TABLE IF NOT EXISTS `remotecenter` (
  `remotecenterid` int(11) NOT NULL,
  `remotecentername` varchar(90) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `district` varchar(45) DEFAULT NULL,
  `active` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `Instituteid` int(11) NOT NULL DEFAULT '0',
  `email` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL,
  `last_updatedby` varchar(20) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `autonomous` varchar(3) DEFAULT 'No',
  `acd_cal_startdate` text,
  `affiliated_university` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`remotecenterid`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `remotecentercapacity`
--

CREATE TABLE IF NOT EXISTS `remotecentercapacity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcid` int(11) NOT NULL,
  `workshopid` int(11) NOT NULL,
  `available_seats` int(11) NOT NULL DEFAULT '0',
  `available_accomo` int(11) NOT NULL DEFAULT '0',
  `allotedrc` int(11) NOT NULL DEFAULT '0',
  `enrolled_status` varchar(10) DEFAULT 'N',
  `acco_cost` varchar(30) DEFAULT NULL,
  `food_cost` varchar(30) DEFAULT NULL,
  `is_rcc_enrolled` varchar(3) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `rcid` (`rcid`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3132 ;

-- --------------------------------------------------------

--
-- Table structure for table `remotecentercapacity_deleted`
--

CREATE TABLE IF NOT EXISTS `remotecentercapacity_deleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rcid` int(11) NOT NULL,
  `workshopid` int(11) NOT NULL,
  `available_seats` int(11) NOT NULL DEFAULT '0',
  `available_accomo` int(11) NOT NULL DEFAULT '0',
  `allotedrc` int(11) NOT NULL DEFAULT '0',
  `loginid` int(11) DEFAULT NULL,
  `deleted_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `rcid` (`rcid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `stateid` int(11) NOT NULL,
  `state` varchar(45) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`stateid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `status_matrix`
--

CREATE TABLE IF NOT EXISTS `status_matrix` (
  `InitialStatus` varchar(30) DEFAULT NULL,
  `Registered` varchar(5) DEFAULT NULL,
  `Invalid` varchar(5) DEFAULT NULL,
  `Approved` varchar(5) DEFAULT NULL,
  `Confirmed` varchar(5) DEFAULT NULL,
  `Completed` varchar(5) DEFAULT NULL,
  `Cancelled` varchar(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `stream`
--
CREATE TABLE IF NOT EXISTS `stream` (
`idstream` varchar(15)
,`stream_name` varchar(240)
,`isActive` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `stream_old`
--

CREATE TABLE IF NOT EXISTS `stream_old` (
  `idstream` int(11) NOT NULL,
  `stream_name` varchar(60) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `surveyemail`
--

CREATE TABLE IF NOT EXISTS `surveyemail` (
  `rcid` text,
  `email` text,
  `firstname` text,
  `lastname` text,
  `instituteid` text,
  `designation` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `temp_mail`
--

CREATE TABLE IF NOT EXISTS `temp_mail` (
  `email` varchar(45) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `uploadfiles`
--

CREATE TABLE IF NOT EXISTS `uploadfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(200) DEFAULT NULL,
  `update_by` int(11) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

-- --------------------------------------------------------

--
-- Table structure for table `uploadscannedattendancedetails`
--

CREATE TABLE IF NOT EXISTS `uploadscannedattendancedetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) DEFAULT NULL,
  `rcid` int(11) DEFAULT NULL,
  `filename` text,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3640 ;

-- --------------------------------------------------------


--
-- Table structure for table `visitorlog`
--

CREATE TABLE IF NOT EXISTS `visitorlog` (
  `visitorid` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipAddress` text,
  PRIMARY KEY (`visitorid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2309987 ;

-- --------------------------------------------------------

--
-- Table structure for table `visitorlogorig`
--

CREATE TABLE IF NOT EXISTS `visitorlogorig` (
  `visitorid` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ipAddress` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `workshops`
--

CREATE TABLE IF NOT EXISTS `workshops` (
  `workshopid` int(11) NOT NULL,
  `workshopname` text NOT NULL,
  `categorycode` int(11) NOT NULL,
  `author` text,
  `introduction` text,
  `objectives` text,
  `eventstatus` text,
  `eventdetailspagepath` text,
  `resourcepath` text,
  `coursewarestatus` text,
  `announcement` text,
  `whoshouldattend` text,
  `note` text,
  `certificatepath` text,
  `broucherpath` text,
  `mailcontentpath` text,
  `contact` text,
  `schedulepath` text,
  `sponsor` text,
  `howtoapply` text,
  `accomodation` text,
  `coursefee` text,
  `teachingfaculty` text,
  `durationandvenue` text,
  `lastdateforappli` text,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `shrtintro` text,
  `shrtobj` text,
  `shrtbenefit` text,
  `contentupdate` tinyint(4) NOT NULL,
  `startdateofappli` date NOT NULL,
  `permissionletter` text NOT NULL,
  `eligibility` text NOT NULL,
  `respective_coordinatorid` int(11) NOT NULL DEFAULT '0',
  `permission_letter_ifrequired` tinyint(1) DEFAULT '1',
  `accomodation_ifavailable` tinyint(1) DEFAULT '1',
  `LMS_Moodle` tinyint(1) DEFAULT '1',
  `LMS_IITBx` tinyint(1) DEFAULT '0',
  `IITBx_coursename` varchar(150) DEFAULT NULL,
  `Moodle_coursename` varchar(150) DEFAULT NULL,
  `certificate_institute_wise` int(11) NOT NULL,
  `certificate_rc_wise` int(11) NOT NULL,
  `instructions` text,
  `certificate_criteria` text,
  `feeamount` varchar(100) DEFAULT NULL,
  `workshop_remark` text,
  `last_updated` timestamp NULL DEFAULT NULL,
  `datetobedisplayed` tinyint(1) DEFAULT NULL,
  `extraDownloads` text,
  `iitb_payment_if_required` tinyint(4) DEFAULT NULL,
  `rc_payment_if_required` tinyint(4) DEFAULT NULL,
  `pseudo_rc_eligible` tinyint(4) DEFAULT NULL,
  `without_RC` tinyint(1) DEFAULT NULL,
  `withdrawal_button_tbd` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`workshopid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `workshop_coordinator`
--

CREATE TABLE IF NOT EXISTS `workshop_coordinator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) NOT NULL,
  `rcid` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  `contextid` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22005 ;

-- --------------------------------------------------------

--
-- Table structure for table `wsc_nominations`
--

CREATE TABLE IF NOT EXISTS `wsc_nominations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workshopid` int(11) NOT NULL,
  `rcid` int(11) NOT NULL,
  `coordinator_email` varchar(70) NOT NULL,
  `nominated_email` varchar(70) NOT NULL,
  `active_till` date NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Structure for view `confirmed_participants`
--
DROP TABLE IF EXISTS `confirmed_participants`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `confirmed_participants` AS select `a`.`workshopid` AS `workshopid`,`a`.`instituteid` AS `rcid`,`a`.`accomodation` AS `accomodation`,`p`.`participantid` AS `participantid`,`p`.`experience` AS `experience`,`p`.`qualification` AS `qualification`,ifnull(`p`.`instituteid`,'0') AS `instituteid`,ifnull(`p`.`streamid`,'0') AS `streamid`,if((`per`.`genderinfo` = 'F'),1,0) AS `Female`,if((`per`.`genderinfo` = 'M'),1,0) AS `Male`,if(isnull(`per`.`genderinfo`),1,0) AS `otherg`,if(isnull(`per`.`experience`),1,0) AS `unknown_exp`,if((`per`.`experience` in ('0-2 years','less than 2 years','less than 2 year')),1,0) AS `less_than_2`,if((`per`.`experience` in ('2-10 years','2-5 years','5-10 years','2 - 5 years','5 - 10 years')),1,0) AS `2_to_10`,if((`per`.`experience` in ('>10 years','> 10 years','more than 10 years')),1,0) AS `greater_than_10`,if((left(`per`.`qualification`,1) in ('P','p')),1,0) AS `Doctorate`,if((left(`per`.`qualification`,1) in ('M','m')),1,0) AS `PostGraduate`,if((left(`per`.`qualification`,1) in ('B','b')),1,0) AS `Graduate`,if((left(`per`.`qualification`,1) in ('D','d')),1,0) AS `Diploma`,(if((left(`per`.`qualification`,1) not in ('D','d','B','b','M','m','P','p')),1,0) + if(isnull(`per`.`qualification`),1,0)) AS `others`,`c`.`email` AS `email`,ifnull(`i`.`city`,'0') AS `city`,ifnull(`i`.`state`,'0') AS `state` from ((((`accomodation` `a` left join `participant` `p` on((`a`.`participantid` = `p`.`participantid`))) left join `context` `c` on((`c`.`idcontext` = `p`.`contextid`))) left join `person` `per` on((`p`.`personid` = `per`.`personid`))) left join `institute` `i` on((`i`.`idInstitute` = `p`.`instituteid`))) where (`p`.`status` in ('Confirmed','Moodle Accessed','Request Confirmed','Completed'));

-- --------------------------------------------------------

--
-- Structure for view `designation`
--
DROP TABLE IF EXISTS `designation`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `designation` AS select `lookups`.`code` AS `iddesignation`,`lookups`.`description` AS `designation`,`lookups`.`isActive` AS `isActive` from `lookups` where (`lookups`.`category` = 'Designation');

-- --------------------------------------------------------

--
-- Structure for view `headdesignation`
--
DROP TABLE IF EXISTS `headdesignation`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `headdesignation` AS select `lookups`.`code` AS `headdesignation_id`,`lookups`.`description` AS `head_designation`,`lookups`.`isActive` AS `isActive` from `lookups` where (`lookups`.`category` = 'HeadDesignation');

-- --------------------------------------------------------

--
-- Structure for view `head_title`
--
DROP TABLE IF EXISTS `head_title`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `head_title` AS select `lookups`.`code` AS `head_title_id`,`lookups`.`description` AS `head_title`,`lookups`.`isActive` AS `isActive` from `lookups` where (`lookups`.`category` = 'HeadTitle');

-- --------------------------------------------------------

--
-- Structure for view `ParticipantTitle`
--
DROP TABLE IF EXISTS `ParticipantTitle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ParticipantTitle` AS select `lookups`.`code` AS `participant_titlte_id`,`lookups`.`description` AS `participanttitle`,`lookups`.`isActive` AS `isActive` from `lookups` where (`lookups`.`category` = 'ParticipantTitle');

-- --------------------------------------------------------

--
-- Structure for view `participant_status`
--
DROP TABLE IF EXISTS `participant_status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `participant_status` AS select `w`.`workshopid` AS `workshop`,`w`.`workshopname` AS `name`,if(isnull(`p`.`status`),'null',if((char_length(`p`.`status`) = 0),'blank',`p`.`status`)) AS `status`,count(0) AS `count`,`w`.`startdate` AS `startdate`,`w`.`enddate` AS `enddate` from ((`participant` `p` join `accomodation` `a`) join `workshops` `w`) where ((`a`.`participantid` = `p`.`participantid`) and (`a`.`workshopid` = `w`.`workshopid`)) group by `w`.`workshopid`,if(isnull(`p`.`status`),'null',if((char_length(`p`.`status`) = 0),'blank',`p`.`status`));

-- --------------------------------------------------------

--
-- Structure for view `participant_status1`
--
DROP TABLE IF EXISTS `participant_status1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `participant_status1` AS select `w`.`workshopid` AS `workshop`,`w`.`workshopname` AS `name`,if(isnull(`p`.`status`),'null',if((char_length(`p`.`status`) = 0),'blank',`p`.`status`)) AS `status`,count(0) AS `count`,`w`.`startdate` AS `startdate`,`w`.`enddate` AS `enddate` from ((`participant` `p` join `accomodation` `a`) join `workshops` `w`) where ((`a`.`participantid` = `p`.`participantid`) and (((`a`.`workshopid` in (`w`.`workshopid`,`w`.`respective_coordinatorid`)) and (`w`.`categorycode` = 5) and (`a`.`workshopid` <> 0)) or ((`w`.`respective_coordinatorid` <> 0) and (`w`.`categorycode` = 4) and (`a`.`workshopid` = `w`.`workshopid`))) and (`w`.`categorycode` in (4,5))) group by `w`.`workshopid`,if(isnull(`p`.`status`),'null',if((char_length(`p`.`status`) = 0),'blank',`p`.`status`));

-- --------------------------------------------------------

--
-- Structure for view `qualification`
--
DROP TABLE IF EXISTS `qualification`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qualification` AS select `lookups`.`code` AS `qualification_id`,`lookups`.`description` AS `qualification`,`lookups`.`isActive` AS `active` from `lookups` where (`lookups`.`category` = 'Qualification');

-- --------------------------------------------------------

--
-- Structure for view `stream`
--
DROP TABLE IF EXISTS `stream`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stream` AS select `lookups`.`code` AS `idstream`,`lookups`.`description` AS `stream_name`,`lookups`.`isActive` AS `isActive` from `lookups` where (`lookups`.`category` = 'Stream');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accomodation`
--
ALTER TABLE `accomodation`
  ADD CONSTRAINT `participant_id` FOREIGN KEY (`participantid`) REFERENCES `participant` (`participantid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `announcementtype`
--
ALTER TABLE `announcementtype`
  ADD CONSTRAINT `announcementtype_ibfk_1` FOREIGN KEY (`type`) REFERENCES `announcement` (`type`);

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`participantid`) REFERENCES `participant` (`participantid`) ON DELETE NO ACTION,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`session`) REFERENCES `program_schedule` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `certificate_audit`
--
ALTER TABLE `certificate_audit`
  ADD CONSTRAINT `certificate_audit_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `person` (`personid`) ON DELETE NO ACTION;

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `stateid` FOREIGN KEY (`stateid`) REFERENCES `state` (`stateid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `institute`
--
ALTER TABLE `institute`
  ADD CONSTRAINT `state` FOREIGN KEY (`state`) REFERENCES `state` (`stateid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `letter`
--
ALTER TABLE `letter`
  ADD CONSTRAINT `participantid` FOREIGN KEY (`participantid`) REFERENCES `participant` (`participantid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`login_id`) REFERENCES `context` (`idcontext`);

--
-- Constraints for table `participant`
--
ALTER TABLE `participant`
  ADD CONSTRAINT `contextid` FOREIGN KEY (`contextid`) REFERENCES `context` (`idcontext`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `personid` FOREIGN KEY (`personid`) REFERENCES `person` (`personid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `participantreasons`
--
ALTER TABLE `participantreasons`
  ADD CONSTRAINT `participantreasons_ibfk_1` FOREIGN KEY (`participantid`) REFERENCES `participant` (`participantid`);

--
-- Constraints for table `remotecenter`
--
ALTER TABLE `remotecenter`
  ADD CONSTRAINT `remotecenter_ibfk_1` FOREIGN KEY (`state`) REFERENCES `state` (`stateid`);

--
-- Constraints for table `remotecentercapacity_deleted`
--
ALTER TABLE `remotecentercapacity_deleted`
  ADD CONSTRAINT `remotecentercapacity_deleted_ibfk_1` FOREIGN KEY (`rcid`) REFERENCES `remotecenter` (`remotecenterid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
