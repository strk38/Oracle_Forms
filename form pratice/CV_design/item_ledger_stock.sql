SELECT COMPANY_CODE,TRANS_DATE,ITEM_CODE,ITEM_NAME,ITEM_UOM,PACK_SIZE PACK_UOM,NVL(SUM(PO_RCV),0) RECEIVED_QTY,NVL(SUM(CONSUMPTION),0) ISSUE_QTY,TRANS_NO,TYPE_TRANS_NO,LOC_CODE,
CASE WHEN TYPE_TRANS_NO  IN ('POR','FGR','MIR','LCR','EXA','COR','PFR','VHR','WCR','OFR','EMR') THEN 1 ELSE 2 END FLAG
 FROM(
SELECT A.COMPANY_CODE,A.ITEM_CODE,B.ITEM_NAME,
SUM(CASE WHEN A.DRCR_FLAG='DR' AND A.TYPE_TRANS_NO  IN ('POR','FGR','MIR','LCR','EXA','COR','PFR','VHR','WCR','OFR','EMR','CVR','SRR','LOT') THEN A.TRANS_QTY ELSE 0 END) PO_RCV,
SUM(CASE WHEN A.DRCR_FLAG='CR'  AND A.TYPE_TRANS_NO  IN('COI','ITD','JOB','CMI','LOA','DMA','SCA','BRA','TFA','WAA','CVI','MSI','LOT') THEN A.TRANS_QTY ELSE 0 END) CONSUMPTION,
B.ITEM_UOM,B.PACK_SIZE,A.TRANS_DATE,A.REF_TRANS_NO TRANS_NO,A.TYPE_TRANS_NO,A.LOC_CODE
FROM INV_ITEM_LEDGER A,INV_ITEM_VW B, INV_ORG_VW D
WHERE TO_DATE(TRANS_DATE,'DD/MM/RRRR') BETWEEN :P_FROM_DATE AND  :P_TO_DATE
AND A.ITEM_CODE =NVL(:P_ITEM_CODE,A.ITEM_CODE)
AND  A.COMPANY_CODE=:P_COMPANY_CODE
AND B.CAT_CODE=NVL(:P_CAT_CODE,B.CAT_CODE)
AND B.TYPE_CODE=NVL(:P_TYPE_CODE,B.TYPE_CODE)
AND (D.REF_ORG_CODE=NVL(:P_ORG_CODE,D.REF_ORG_CODE) OR A.ORG_CODE=NVL(:P_ORG_CODE,A.ORG_CODE))
AND A.ITEM_CODE=B.ITEM_CODE
AND A.COMPANY_CODE=B.COMPANY_CODE
AND A.ORG_CODE=D.ORG_CODE
AND B.COMPANY_CODE=D.COMPANY_CODE
GROUP BY A.COMPANY_CODE,A.ITEM_CODE,B.ITEM_NAME,B.ITEM_UOM,B.PACK_SIZE,A.TRANS_DATE,A.REF_TRANS_NO,A.TYPE_TRANS_NO,A.LOC_CODE)
GROUP BY COMPANY_CODE,ITEM_CODE,ITEM_NAME,ITEM_UOM,PACK_SIZE,TRANS_DATE,TRANS_NO,TYPE_TRANS_NO,LOC_CODE
ORDER BY TRANS_DATE,FLAG ASC
