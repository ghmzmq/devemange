///////////////////////////////////////////////////////////////////////////////
//  ���ã�����ִ�����ݿ�����Ľӿ���
//  �ļ�����BFSSDbOprIntf.pas  �汾��1.0
//  �ӿ�֧�ֿ�: BFSSDBOpr.dll  
//  �������ڣ�2007-11-1       ���ߣ�������
//
//
//  �޸�ʱ��: 2007-11-28 ����: ������
//  �޸�����: ����mailto�ӿ�
//  ����޸�: 2007-11-29
//
//  ������AppServer�ӿڵ�����
//
//******************************************************************************}
//
// ʹ�÷���:
//   �ڹ������ֶ���:
//
//   function CreateBfssDBOpr(AConnectStype:Word): IDbOperator; stdcall;
//    ����: AConnectStype = 0 ��ʾ����DCOM����
//                        = 1 ��ʾ����Socke����
//   function CreateDbOperator; stdcall; external 'DBapi.Dll';
//
//
////////////////////////////////////////////////////////////////////////////////
unit DbApiIntf;

interface

uses
  Windows, DBClient;

const
  cnEmptyIntValue: Integer = -1;
  cnCurDbOprVersion = 1;

type

  TConnectStype = (csDCOM,csSocket); 

  IDbOperator = interface
    //1.�������ݿ�
    function Connect(AConnStype:word;const AHost: PChar;const APort: Word = 0): Boolean; stdcall;
    function DisConnect(): Boolean; stdcall;
    function ReConnect(): Boolean; stdcall;
    //2.���׿���
    procedure BeginTrans; stdcall;
    procedure CommitTrans; stdcall;
    procedure RollbackTrans; stdcall;
    //3.ִ��SQL ���
    function ExeSQL(const SqlStr: PChar): Boolean; stdcall;
    function ReadInt(const SqlStr: PChar): Integer; stdcall;
    function ReadRecord(const SqlStr: PChar): OleVariant; stdcall;
    function ReadDataSet(const SqlStr: PChar): OleVariant; stdcall;
    function ReadVariant(const SqlStr: PChar): OleVariant; stdcall;
    function ReadRecordCount(const SqlStr: PChar): Integer; stdcall;
    function ReadBlob(const SqlStr: PChar; var Buf; Len: Integer): Integer; stdcall;
    function RefreshData(const AData: TClientDataSet; const SqlStr: PChar): Boolean; stdcall;
    //
    // DoExecute ��ִ�в���SQL�����Param��������������,
    // ��ExeSQL ��ͬ�ģ�ExeSQLû��Param����ֵ
    // ����:
    //  ASqlStr ΪSQL���
    //  AParams ���� PackageParams(cdsQuery.Params) �������á�
    //
    procedure DoExecute(ASqlStr:WideString;AParams: OleVariant); stdcall;

    //4.AppServer �ӿ�
    function Login(const AName: WideString; const APass: WideString):integer;stdcall;
    function CopyFile(AFile_ID: Integer; AVer: Integer; ATree_ID: Integer): Integer; safecall;
    function DeleteFile(AFile_ID: Integer): Integer; safecall;
    function UpFileChunk(AFile_ID: Integer; AVer: Integer; AGroupID: Integer; AStream: OleVariant): Integer; safecall;
    //
    // AStyle ���ͣ�Ŀǰֻ��Bug=0
    // AMails ��ʾ�����б��� mrlong.com@gmail.com;mrlng_xp@163.com
    // AContextID ���ݣ��ǰ�������ȷ���ġ���bug����bug_idֵ
    //
    procedure MailTo(AStyle: Integer; const AMails: WideString; AContextID: Integer); safecall;
    
    //5.����
    function Connected(): Boolean; stdcall;
    function Version : integer;stdcall;
    function AppServer : Variant; stdcall;
  end;


implementation

end.