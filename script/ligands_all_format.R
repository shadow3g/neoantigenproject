# --------------
# Date:  2019-11-10 19:13:51 
# Author:JijunYu
# Email: jijunyu140@gmail.com
# --------------
# About project: This script change the format of ligands_all.file
# 
#####parameter######
basic_path = "./data_project"
ligands = paste(basic_path,"Ligands/revision_data",sep = "/")
####################
library(seqinr)
file_list = list.files(ligands)
fastafile<-read.fasta(paste(ligands,file_list[2],sep = "/"), seqtype = "AA",as.string = TRUE)
fasta_anno = getAnnot(fastafile)
for(i in seq(1, length(fasta_anno))){
  print(i)
  anno_i = fasta_anno[[i]]
  anno_i = gsub("\t"," ", anno_i)
  str_i_split = str_split(anno_i, " ")[[1]]
  if (length(str_i_split)==4){
    str_i_split_4 = str_split(str_i_split[4],"",n=2)
    str_i_split_4_revision = paste0("HLA-",str_i_split_4[[1]][1],sep="")
    str_i_split_5 = str_i_split_4[[1]][2]
    if(str_i_split_4_revision == "HLA-C"){
      str_i_split_5x = str_split_fixed(str_i_split_5,"",n=2)
      str_i_split_4_revision = paste(paste0(str_i_split_4_revision,str_i_split_5x[,1],collapse = ""),str_i_split_5x[,2],sep = "*")
    }else{
      str_i_split_4_revision = paste(str_i_split_4_revision,str_i_split_5,sep = "*")
    }
    fasta_anno[[i]] = paste(str_i_split[1],str_i_split[2],str_i_split[3],str_i_split_4_revision,collapse ="\t")
    print(fasta_anno[[i]])
  }else{
    fasta_anno[[i]] = paste(anno_i,"HLA-G",collapse = " ")
    print(fasta_anno[[i]])
  }
}
fasta_sequence <- getSequence(fastafile)
write.fasta(fasta_sequence, fasta_anno, paste(ligands,"Ligand_MHC_all.fasta",sep = "/"),nbchar = 10000)

